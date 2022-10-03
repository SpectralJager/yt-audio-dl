package services

import (
	"backend/internal/core/domain"
	"context"
	"errors"
	"io"
	"strings"

	"github.com/kkdai/youtube/v2"
)

type YTVideoService struct {
	yt *domain.Youtube
}

func NewYTVideoService() *YTVideoService {
	y := domain.NewYoutube(false)
	return &YTVideoService{
		yt: y,
	}
}

func (s *YTVideoService) VideoGetMeta(videoId string) (map[string]interface{}, error) {
	if videoId == "" {
		return nil, errors.New("empty 'videoId' field")
	}
	ctx := context.Background()
	return s.yt.GetVideoMetadata(ctx, videoId)

}

func (s *YTVideoService) VideoGetStream(videoId string, format youtube.Format) (io.ReadCloser, int64, error) {
	if videoId == "" {
		return nil, 0, errors.New("empty 'videoId' field")
	}
	if !strings.Contains(format.MimeType, "audio/mp4") {
		return nil, 0, errors.New("wrong 'format', MimeType should be 'audio/mp4'")
	}
	ctx := context.Background()
	return s.yt.GetVideoStream(ctx, videoId, format)
}

func (s *YTVideoService) PlaylistGetMeta(playlistId string) (map[string]interface{}, error) {
	if playlistId == "" {
		return nil, errors.New("empty 'playlistId' field")
	}
	ctx := context.Background()
	return s.yt.GetPlaylistMetadata(ctx, playlistId)
}
