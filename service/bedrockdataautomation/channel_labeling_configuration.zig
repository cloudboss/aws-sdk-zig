const State = @import("state.zig").State;

/// Channel labeling configuration
pub const ChannelLabelingConfiguration = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
