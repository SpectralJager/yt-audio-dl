package domain

import (
	"context"
	"io"

	yt "github.com/kkdai/youtube/v2"
)

type Youtube struct {
	client *yt.Client
}

func NewYoutube(debug bool) *Youtube {
	youtubeClient := yt.Client{
		Debug: debug,
	}
	return &Youtube{
		client: &youtubeClient,
	}
}

func (s *Youtube) GetVideoMetadata(ctx context.Context, videoId string) (map[string]interface{}, error) {
	video, err := s.client.GetVideoContext(ctx, videoId)
	if err != nil {
		return map[string]interface{}{}, err
	}
	metadata := map[string]interface{}{
		"VideoId":  video.ID,
		"Title":    video.Title,
		"Author":   video.Author,
		"Duration": video.Duration.String(),
		"Formats":  video.Formats.WithAudioChannels().Type("audio/mp4"),
	}
	return metadata, nil
}

func (s *Youtube) GetVideoStream(ctx context.Context, videoId string, format yt.Format) (io.ReadCloser, int64, error) {
	video, err := s.client.GetVideoContext(ctx, videoId)
	if err != nil {
		return nil, 0, err
	}
	stream, size, err := s.client.GetStreamContext(ctx, video, &format)
	if err != nil {
		return nil, 0, err
	}
	return stream, size, err
}

func (s *Youtube) GetPlaylistMetadata(ctx context.Context, playlistId string) (map[string]interface{}, error) {
	playlist, err := s.client.GetPlaylistContext(ctx, playlistId)
	if err != nil {
		return map[string]interface{}{}, err
	}
	metadata := map[string]interface{}{
		"PlaylistId": playlist.ID,
		"Title":      playlist.Title,
		"Author":     playlist.Author,
		"Videos":     playlist.Videos,
	}
	return metadata, nil
}
