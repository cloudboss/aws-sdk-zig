const ArtifactsConcatenationState = @import("artifacts_concatenation_state.zig").ArtifactsConcatenationState;

/// The composited content configuration object for a specified
/// media pipeline.
pub const ContentConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: ArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
