///
//  Generated code. Do not modify.
//  source: pkg/proto/youtube-service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'youtube-service.pb.dart' as $0;
export 'youtube-service.pb.dart';

class YoutubeGRPCServiceClient extends $grpc.Client {
  static final _$videoGetMeta = $grpc.ClientMethod<$0.VideoGetReq, $0.Video>(
      '/pb.YoutubeGRPCService/VideoGetMeta',
      ($0.VideoGetReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Video.fromBuffer(value));
  static final _$videoGetStream =
      $grpc.ClientMethod<$0.VideoGetReq, $0.VideoStreamResp>(
          '/pb.YoutubeGRPCService/VideoGetStream',
          ($0.VideoGetReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VideoStreamResp.fromBuffer(value));
  static final _$playlistGetMeta =
      $grpc.ClientMethod<$0.PlaylistGetReq, $0.Playlist>(
          '/pb.YoutubeGRPCService/PlaylistGetMeta',
          ($0.PlaylistGetReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Playlist.fromBuffer(value));

  YoutubeGRPCServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Video> videoGetMeta($0.VideoGetReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$videoGetMeta, request, options: options);
  }

  $grpc.ResponseStream<$0.VideoStreamResp> videoGetStream(
      $0.VideoGetReq request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$videoGetStream, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Playlist> playlistGetMeta($0.PlaylistGetReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$playlistGetMeta, request, options: options);
  }
}

abstract class YoutubeGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.YoutubeGRPCService';

  YoutubeGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.VideoGetReq, $0.Video>(
        'VideoGetMeta',
        videoGetMeta_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VideoGetReq.fromBuffer(value),
        ($0.Video value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VideoGetReq, $0.VideoStreamResp>(
        'VideoGetStream',
        videoGetStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.VideoGetReq.fromBuffer(value),
        ($0.VideoStreamResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlaylistGetReq, $0.Playlist>(
        'PlaylistGetMeta',
        playlistGetMeta_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlaylistGetReq.fromBuffer(value),
        ($0.Playlist value) => value.writeToBuffer()));
  }

  $async.Future<$0.Video> videoGetMeta_Pre(
      $grpc.ServiceCall call, $async.Future<$0.VideoGetReq> request) async {
    return videoGetMeta(call, await request);
  }

  $async.Stream<$0.VideoStreamResp> videoGetStream_Pre(
      $grpc.ServiceCall call, $async.Future<$0.VideoGetReq> request) async* {
    yield* videoGetStream(call, await request);
  }

  $async.Future<$0.Playlist> playlistGetMeta_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PlaylistGetReq> request) async {
    return playlistGetMeta(call, await request);
  }

  $async.Future<$0.Video> videoGetMeta(
      $grpc.ServiceCall call, $0.VideoGetReq request);
  $async.Stream<$0.VideoStreamResp> videoGetStream(
      $grpc.ServiceCall call, $0.VideoGetReq request);
  $async.Future<$0.Playlist> playlistGetMeta(
      $grpc.ServiceCall call, $0.PlaylistGetReq request);
}
