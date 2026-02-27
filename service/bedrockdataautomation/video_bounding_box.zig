const State = @import("state.zig").State;

/// Bounding Box Configuration of Video Extraction
pub const VideoBoundingBox = struct {
    state: State,

    pub const json_field_names = .{
        .state = "state",
    };
};
