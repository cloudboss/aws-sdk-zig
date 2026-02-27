const MediaStreamType = @import("media_stream_type.zig").MediaStreamType;
const MediaStreamPipelineSinkType = @import("media_stream_pipeline_sink_type.zig").MediaStreamPipelineSinkType;

/// Structure that contains the settings for a media stream sink.
pub const MediaStreamSink = struct {
    /// The media stream sink's media stream type.
    media_stream_type: MediaStreamType,

    /// Specifies the number of streams that the sink can accept.
    reserved_stream_capacity: i32,

    /// The ARN of the Kinesis Video Stream pool returned by the
    /// CreateMediaPipelineKinesisVideoStreamPool API.
    sink_arn: []const u8,

    /// The media stream sink's type.
    sink_type: MediaStreamPipelineSinkType,

    pub const json_field_names = .{
        .media_stream_type = "MediaStreamType",
        .reserved_stream_capacity = "ReservedStreamCapacity",
        .sink_arn = "SinkArn",
        .sink_type = "SinkType",
    };
};
