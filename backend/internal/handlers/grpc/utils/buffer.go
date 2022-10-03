package utils

type Buffer struct {
	Bytes []byte
}

func (s *Buffer) Write(p []byte) (n int, err error) {
	s.Bytes = p
	return len(p), nil
}
