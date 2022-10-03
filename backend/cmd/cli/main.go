package main

import (
	cliHandler "backend/internal/handlers/cli"
	"flag"
	"log"
)

func main() {
	videoId := ""
	playlistId := ""
	storagePath := ""
	playlistDir := false

	flag.StringVar(&videoId, "v", "", "videoId or url to download")
	flag.StringVar(&playlistId, "p", "", "playlistId or url to download")
	flag.StringVar(&storagePath, "o", "", "storage path for file")
	flag.BoolVar(&playlistDir, "pl-dir", false, "create additional folder for playlist")

	flag.Parse()

	if playlistId != "" && videoId != "" {
		log.Fatal("enter only 'videoId' or 'playlistId' ")
	}

	cliApp := cliHandler.NewCliApp()

	switch {
	case videoId != "":
		err := cliApp.DownloadVideoFromId(storagePath, videoId)
		if err != nil {
			log.Fatal(err)
		}
	case playlistId != "":
		err := cliApp.DownloadVideosFromPlaylistId(storagePath, playlistId, playlistDir)
		if err != nil {
			log.Fatal(err)
		}
	default:
		log.Fatal("videoId or playlistId required")
	}
}
