const MediaStreamSink = @import("media_stream_sink.zig").MediaStreamSink;
const MediaStreamSource = @import("media_stream_source.zig").MediaStreamSource;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// Structure that contains the settings for a media stream pipeline.
pub const MediaStreamPipeline = struct {
    /// The time at which the media stream pipeline was created.
    created_timestamp: ?i64,

    /// The ARN of the media stream pipeline.
    media_pipeline_arn: ?[]const u8,

    /// The ID of the media stream pipeline
    media_pipeline_id: ?[]const u8,

    /// The media stream pipeline's data sinks.
    sinks: ?[]const MediaStreamSink,

    /// The media stream pipeline's data sources.
    sources: ?[]const MediaStreamSource,

    /// The status of the media stream pipeline.
    status: ?MediaPipelineStatus,

    /// The time at which the media stream pipeline was updated.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .media_pipeline_arn = "MediaPipelineArn",
        .media_pipeline_id = "MediaPipelineId",
        .sinks = "Sinks",
        .sources = "Sources",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
