package grpcHandler

import (
	"context"
	"fmt"
	"log"

	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
)

func (s *GRPCServer) UnaryInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	unaryLogger(ctx, info)
	return handler(ctx, req)
}

func unaryLogger(ctx context.Context, info *grpc.UnaryServerInfo) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return
	}
	log.Printf("---> %v", info.FullMethod)
	fmt.Printf("\t authority: %v\n", md.Get(":authority"))
	fmt.Printf("\t user-agent: %v\n", md.Get("user-agent"))
}

func (s *GRPCServer) StreamServerInterceptor(srv interface{}, ss grpc.ServerStream, info *grpc.StreamServerInfo, handler grpc.StreamHandler) error {
	streamLogger(ss.Context(), info)
	return handler(srv, ss)
}

func streamLogger(ctx context.Context, info *grpc.StreamServerInfo) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return
	}
	log.Printf("---> %v", info.FullMethod)
	fmt.Printf("\t authority: %v\n", md.Get(":authority"))
	fmt.Printf("\t user-agent: %v\n", md.Get("user-agent"))
}
