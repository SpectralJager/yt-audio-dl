package main

import (
	grpcHandler "backend/internal/handlers/grpc"
	"backend/internal/handlers/grpc/pb"
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"
)

const (
	port int    = 8080
	addr string = ""
)

func main() {
	handler := grpcHandler.NewGRPCServer()
	server := grpc.NewServer(
		grpc.MaxSendMsgSize(1024*1024*50),
		grpc.UnaryInterceptor(
			handler.UnaryInterceptor,
		),
		grpc.StreamInterceptor(
			handler.StreamServerInterceptor,
		),
	)

	pb.RegisterYoutubeGRPCServiceServer(server, handler)

	lis, err := net.Listen("tcp", fmt.Sprintf("%s:%d", addr, port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Printf("listen %s on port: %d", addr, port)
	if err = server.Serve(lis); err != nil {
		log.Fatalf("something goes wrong: %v", err)
	}
}
