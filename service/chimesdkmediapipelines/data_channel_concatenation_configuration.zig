const ArtifactsConcatenationState = @import("artifacts_concatenation_state.zig").ArtifactsConcatenationState;

/// The content configuration object's data channel.
pub const DataChannelConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: ArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
