const State = @import("state.zig").State;

/// Bounding Box Configuration of Image Extraction
pub const ImageBoundingBox = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
