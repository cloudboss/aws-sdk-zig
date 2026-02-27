const State = @import("state.zig").State;

/// Standard Generative Field Configuration of Document
pub const DocumentStandardGenerativeField = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
