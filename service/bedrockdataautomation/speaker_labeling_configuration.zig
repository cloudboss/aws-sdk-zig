const State = @import("state.zig").State;

/// Speaker labeling configuration
pub const SpeakerLabelingConfiguration = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
