const MediaStreamSink = @import("media_stream_sink.zig").MediaStreamSink;
const MediaStreamSource = @import("media_stream_source.zig").MediaStreamSource;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// Structure that contains the settings for a media stream pipeline.
pub const MediaStreamPipeline = struct {
    /// The time at which the media stream pipeline was created.
    created_timestamp: ?i64 = null,

    /// The ARN of the media stream pipeline.
    media_pipeline_arn: ?[]const u8 = null,

    /// The ID of the media stream pipeline
    media_pipeline_id: ?[]const u8 = null,

    /// The media stream pipeline's data sinks.
    sinks: ?[]const MediaStreamSink = null,

    /// The media stream pipeline's data sources.
    sources: ?[]const MediaStreamSource = null,

    /// The status of the media stream pipeline.
    status: ?MediaPipelineStatus = null,

    /// The time at which the media stream pipeline was updated.
    updated_timestamp: ?i64 = null,

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
