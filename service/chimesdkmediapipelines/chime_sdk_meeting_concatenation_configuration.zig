const ArtifactsConcatenationConfiguration = @import("artifacts_concatenation_configuration.zig").ArtifactsConcatenationConfiguration;

/// The configuration object of the Amazon Chime SDK meeting concatenation for a
/// specified
/// media pipeline.
pub const ChimeSdkMeetingConcatenationConfiguration = struct {
    /// The configuration for the artifacts in an Amazon Chime SDK meeting
    /// concatenation.
    artifacts_configuration: ArtifactsConcatenationConfiguration,

    pub const json_field_names = .{
        .artifacts_configuration = "ArtifactsConfiguration",
    };
};
