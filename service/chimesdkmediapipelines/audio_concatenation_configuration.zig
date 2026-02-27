const AudioArtifactsConcatenationState = @import("audio_artifacts_concatenation_state.zig").AudioArtifactsConcatenationState;

/// The audio artifact concatenation configuration object.
pub const AudioConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: AudioArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
