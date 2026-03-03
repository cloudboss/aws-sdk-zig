const ArtifactsConfiguration = @import("artifacts_configuration.zig").ArtifactsConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;

/// The configuration object of the Amazon Chime SDK meeting for a specified
/// media pipeline. `SourceType` must be `ChimeSdkMeeting`.
pub const ChimeSdkMeetingConfiguration = struct {
    /// The configuration for the artifacts in an Amazon Chime SDK meeting.
    artifacts_configuration: ?ArtifactsConfiguration = null,

    /// The source configuration for a specified media pipeline.
    source_configuration: ?SourceConfiguration = null,

    pub const json_field_names = .{
        .artifacts_configuration = "ArtifactsConfiguration",
        .source_configuration = "SourceConfiguration",
    };
};
