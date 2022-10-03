package ports

import (
	"io"

	"github.com/kkdai/youtube/v2"
)

type YTVideoService interface {
	VideoGetMeta(videoId string) (map[string]interface{}, error)
	VideoGetStream(videoId string, format youtube.Format) (io.ReadCloser, int64, error)
	PlaylistGetMeta(playlistId string) (map[string]interface{}, error)
}
