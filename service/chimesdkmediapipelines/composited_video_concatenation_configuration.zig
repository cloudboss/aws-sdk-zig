const ArtifactsConcatenationState = @import("artifacts_concatenation_state.zig").ArtifactsConcatenationState;

/// The composited video configuration object for a specified
/// media pipeline. `SourceType` must be
/// `ChimeSdkMeeting`.
pub const CompositedVideoConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: ArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
