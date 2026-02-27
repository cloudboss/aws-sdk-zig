const ArtifactsConcatenationState = @import("artifacts_concatenation_state.zig").ArtifactsConcatenationState;

/// The configuration object of a video concatenation pipeline.
pub const VideoConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: ArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
