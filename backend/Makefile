gen-grpc: 
	protoc --go_out=internal/handlers/grpc --go-grpc_out=internal/handlers/grpc --dart_out="grpc:../frontend/lib/repositories/grpc/pb" pkg/proto/*.proto

cli:
	go build -o yt-cli cmd/cli/main.go

grpc:
	go build -o yt-grpc cmd/grpc/main.go