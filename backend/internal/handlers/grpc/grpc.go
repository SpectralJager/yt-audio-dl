package grpcHandler

import (
	"backend/internal/core/ports"
	"backend/internal/core/services"
	pb "backend/internal/handlers/grpc/pb"
	"context"
	"io"

	"github.com/kkdai/youtube/v2"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

const (
	max_chunk int64 = 1 << 14
)

type GRPCServer struct {
	pb.UnimplementedYoutubeGRPCServiceServer
	ytVideoService ports.YTVideoService
}

func NewGRPCServer() *GRPCServer {
	ytService := services.NewYTVideoService()
	return &GRPCServer{
		ytVideoService: ytService,
	}
}

func (s *GRPCServer) VideoGetMeta(ctx context.Context, req *pb.VideoGetReq) (*pb.Video, error) {
	meta, err := s.ytVideoService.VideoGetMeta(req.VideoId)
	if err != nil {
		return nil, status.Error(codes.Unavailable, "cant access video")
	}
	return &pb.Video{
		ID:       meta["VideoId"].(string),
		Title:    meta["Title"].(string),
		Author:   meta["Author"].(string),
		Duration: meta["Duration"].(string),
	}, nil
}

func (s *GRPCServer) VideoGetStream(req *pb.VideoGetReq, resp_stream pb.YoutubeGRPCService_VideoGetStreamServer) error {
	meta, err := s.ytVideoService.VideoGetMeta(req.VideoId)
	if err != nil {
		return status.Error(codes.Unavailable, "cant access video")
	}

	stream, size, err := s.ytVideoService.VideoGetStream(req.VideoId, meta["Formats"].(youtube.FormatList)[0])
	if err != nil {
		return status.Error(codes.Unavailable, "cant access video")
	}

	var chunk int64 = 0
	if size < max_chunk {
		chunk = size
	} else {
		chunk = max_chunk
	}

	var done int64 = 0
	buf := make([]byte, chunk)
	for {
		w, err := stream.Read(buf)
		if err == io.EOF {
			break
		}

		done += int64(w)

		if e := resp_stream.Send(&pb.VideoStreamResp{Data: buf[:w], Total: size, Ready: done}); e != nil {
			return status.Error(codes.Internal, "cant send video")
		}
		if err != nil {
			break
		}
	}
	return nil
}

func (s *GRPCServer) PlaylistGetMeta(ctx context.Context, req *pb.PlaylistGetReq) (*pb.Playlist, error) {
	meta, err := s.ytVideoService.PlaylistGetMeta(req.PlaylistId)
	if err != nil {
		return nil, status.Error(codes.Unavailable, "cant access playlist")
	}

	videos := []*pb.Video{}
	for _, e := range meta["Videos"].([]*youtube.PlaylistEntry) {
		video := pb.Video{
			ID:       e.ID,
			Title:    e.Title,
			Author:   e.Author,
			Duration: e.Duration.String(),
		}

		videos = append(videos, &video)
	}
	return &pb.Playlist{
		ID:     meta["PlaylistId"].(string),
		Title:  meta["Title"].(string),
		Author: meta["Author"].(string),
		Videos: videos,
	}, nil
}
