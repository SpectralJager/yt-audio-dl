///
//  Generated code. Do not modify.
//  source: pkg/proto/youtube-service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use videoDescriptor instead')
const Video$json = const {
  '1': 'Video',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 9, '10': 'ID'},
    const {'1': 'Title', '3': 2, '4': 1, '5': 9, '10': 'Title'},
    const {'1': 'Author', '3': 3, '4': 1, '5': 9, '10': 'Author'},
    const {'1': 'Duration', '3': 4, '4': 1, '5': 9, '10': 'Duration'},
  ],
};

/// Descriptor for `Video`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDescriptor = $convert.base64Decode('CgVWaWRlbxIOCgJJRBgBIAEoCVICSUQSFAoFVGl0bGUYAiABKAlSBVRpdGxlEhYKBkF1dGhvchgDIAEoCVIGQXV0aG9yEhoKCER1cmF0aW9uGAQgASgJUghEdXJhdGlvbg==');
@$core.Deprecated('Use playlistDescriptor instead')
const Playlist$json = const {
  '1': 'Playlist',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 9, '10': 'ID'},
    const {'1': 'Title', '3': 2, '4': 1, '5': 9, '10': 'Title'},
    const {'1': 'Author', '3': 3, '4': 1, '5': 9, '10': 'Author'},
    const {'1': 'Videos', '3': 4, '4': 3, '5': 11, '6': '.pb.Video', '10': 'Videos'},
  ],
};

/// Descriptor for `Playlist`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playlistDescriptor = $convert.base64Decode('CghQbGF5bGlzdBIOCgJJRBgBIAEoCVICSUQSFAoFVGl0bGUYAiABKAlSBVRpdGxlEhYKBkF1dGhvchgDIAEoCVIGQXV0aG9yEiEKBlZpZGVvcxgEIAMoCzIJLnBiLlZpZGVvUgZWaWRlb3M=');
@$core.Deprecated('Use videoGetReqDescriptor instead')
const VideoGetReq$json = const {
  '1': 'VideoGetReq',
  '2': const [
    const {'1': 'videoId', '3': 1, '4': 1, '5': 9, '10': 'videoId'},
  ],
};

/// Descriptor for `VideoGetReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoGetReqDescriptor = $convert.base64Decode('CgtWaWRlb0dldFJlcRIYCgd2aWRlb0lkGAEgASgJUgd2aWRlb0lk');
@$core.Deprecated('Use videoStreamRespDescriptor instead')
const VideoStreamResp$json = const {
  '1': 'VideoStreamResp',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'ready', '3': 2, '4': 1, '5': 3, '10': 'ready'},
    const {'1': 'total', '3': 3, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `VideoStreamResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoStreamRespDescriptor = $convert.base64Decode('Cg9WaWRlb1N0cmVhbVJlc3ASEgoEZGF0YRgBIAEoDFIEZGF0YRIUCgVyZWFkeRgCIAEoA1IFcmVhZHkSFAoFdG90YWwYAyABKANSBXRvdGFs');
@$core.Deprecated('Use playlistGetReqDescriptor instead')
const PlaylistGetReq$json = const {
  '1': 'PlaylistGetReq',
  '2': const [
    const {'1': 'playlistId', '3': 1, '4': 1, '5': 9, '10': 'playlistId'},
  ],
};

/// Descriptor for `PlaylistGetReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playlistGetReqDescriptor = $convert.base64Decode('Cg5QbGF5bGlzdEdldFJlcRIeCgpwbGF5bGlzdElkGAEgASgJUgpwbGF5bGlzdElk');
