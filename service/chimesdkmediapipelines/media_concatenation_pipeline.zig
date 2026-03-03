const ConcatenationSink = @import("concatenation_sink.zig").ConcatenationSink;
const ConcatenationSource = @import("concatenation_source.zig").ConcatenationSource;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// Concatenates audio and video data from one or more data streams.
pub const MediaConcatenationPipeline = struct {
    /// The time at which the concatenation pipeline was created.
    created_timestamp: ?i64 = null,

    /// The ARN of the media pipeline that you specify in the `SourceConfiguration`
    /// object.
    media_pipeline_arn: ?[]const u8 = null,

    /// The ID of the media pipeline being concatenated.
    media_pipeline_id: ?[]const u8 = null,

    /// The data sinks of the concatenation pipeline.
    sinks: ?[]const ConcatenationSink = null,

    /// The data sources being concatenated.
    sources: ?[]const ConcatenationSource = null,

    /// The status of the concatenation pipeline.
    status: ?MediaPipelineStatus = null,

    /// The time at which the concatenation pipeline was last updated.
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
