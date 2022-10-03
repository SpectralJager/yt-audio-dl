package cliHandler

import (
	ports "backend/internal/core/ports"
	services "backend/internal/core/services"
	"fmt"
	"io"
	"log"
	"os"
	"path"
	"sync"

	"github.com/kkdai/youtube/v2"
	"github.com/schollz/progressbar/v3"
)

var (
	videoKeys = []string{
		"VideoId",
		"Title",
		"Author",
		"Duration",
		"Formats",
	}
	playlistKeys = []string{
		"PlaylistId",
		"Title",
		"Author",
		"Videos",
	}
)

type CliApp struct {
	ytVideoService ports.YTVideoService
}

func NewCliApp() *CliApp {
	ytService := services.NewYTVideoService()
	return &CliApp{
		ytVideoService: ytService,
	}
}

func (s *CliApp) DownloadVideoFromId(storagePath, videoId string) error {
	meta, err := s.ytVideoService.VideoGetMeta(videoId)
	if err != nil {
		return err
	}
	for _, k := range videoKeys {
		if k == "Formats" {
			continue
		}
		fmt.Printf("%s: %v\n", k, meta[k])
	}
	return s.downloadVideo(storagePath, meta)
}

func (s *CliApp) DownloadVideosFromPlaylistId(storagePath, playlistId string, playlistDir bool) error {
	meta, err := s.ytVideoService.PlaylistGetMeta(playlistId)
	if err != nil {
		return err
	}

	if playlistDir {
		storagePath = path.Join(storagePath, meta["Title"].(string))
	}
	log.Println(storagePath)

	for _, k := range playlistKeys {
		if k == "Videos" {
			fmt.Println(k)
			for i, e := range meta[k].([]*youtube.PlaylistEntry) {
				fmt.Printf("#%d\t%s %s %v\n", i, e.Title, e.Author, e.Duration.String())
			}
			continue
		}
		fmt.Printf("%s: %v\n", k, meta[k])
	}

	wg := sync.WaitGroup{}

	for _, e := range meta["Videos"].([]*youtube.PlaylistEntry) {
		videoMeta, err := s.ytVideoService.VideoGetMeta(e.ID)
		if err != nil {
			continue
		}

		wg.Add(1)
		go func() {
			s.downloadVideo(storagePath, videoMeta)
			wg.Done()
		}()
	}
	wg.Wait()
	return nil
}

func (s *CliApp) downloadVideo(storagePath string, meta map[string]interface{}) error {
	err := os.MkdirAll(storagePath, os.ModePerm)
	if err != nil {
		return err
	}

	path := path.Join(storagePath, meta["Title"].(string)+".mp3")
	file, err := os.Create(path)
	if err != nil {
		return err
	}
	defer file.Close()

	stream, size, err := s.ytVideoService.VideoGetStream(meta["VideoId"].(string), meta["Formats"].(youtube.FormatList)[0])
	if err != nil {
		return err
	}

	bar := progressbar.DefaultBytes(
		size,
		fmt.Sprintf("Download: %v", meta["Title"]),
	)
	_, err = io.CopyN(io.MultiWriter(file, bar), stream, size)
	return err
}
