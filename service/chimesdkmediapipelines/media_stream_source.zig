const MediaPipelineSourceType = @import("media_pipeline_source_type.zig").MediaPipelineSourceType;

/// Structure that contains the settings for media stream sources.
pub const MediaStreamSource = struct {
    /// The ARN of the meeting.
    source_arn: []const u8,

    /// The type of media stream source.
    source_type: MediaPipelineSourceType,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .source_type = "SourceType",
    };
};
