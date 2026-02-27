const State = @import("state.zig").State;

/// Bounding Box Configuration of Document Extraction
pub const DocumentBoundingBox = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
