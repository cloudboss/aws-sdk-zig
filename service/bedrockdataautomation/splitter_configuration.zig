const State = @import("state.zig").State;

/// Configuration of Splitter
pub const SplitterConfiguration = struct {
    state: ?State,

    pub const json_field_names = .{
        .state = "state",
    };
};
