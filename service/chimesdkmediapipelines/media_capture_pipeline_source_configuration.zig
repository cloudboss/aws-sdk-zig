const ChimeSdkMeetingConcatenationConfiguration = @import("chime_sdk_meeting_concatenation_configuration.zig").ChimeSdkMeetingConcatenationConfiguration;

/// The source configuration object of a media capture pipeline.
pub const MediaCapturePipelineSourceConfiguration = struct {
    /// The meeting configuration settings in a media capture pipeline configuration
    /// object.
    chime_sdk_meeting_configuration: ChimeSdkMeetingConcatenationConfiguration,

    /// The media pipeline ARN in the configuration object of a media capture
    /// pipeline.
    media_pipeline_arn: []const u8,

    pub const json_field_names = .{
        .chime_sdk_meeting_configuration = "ChimeSdkMeetingConfiguration",
        .media_pipeline_arn = "MediaPipelineArn",
    };
};
