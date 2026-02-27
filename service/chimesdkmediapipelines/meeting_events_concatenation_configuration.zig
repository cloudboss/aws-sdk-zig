const ArtifactsConcatenationState = @import("artifacts_concatenation_state.zig").ArtifactsConcatenationState;

/// The configuration object for an event concatenation pipeline.
pub const MeetingEventsConcatenationConfiguration = struct {
    /// Enables or disables the configuration object.
    state: ArtifactsConcatenationState,

    pub const json_field_names = .{
        .state = "State",
    };
};
