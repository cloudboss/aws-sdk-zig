const State = @import("state.zig").State;

/// Additional File Format of Document Output
pub const DocumentOutputAdditionalFileFormat = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
