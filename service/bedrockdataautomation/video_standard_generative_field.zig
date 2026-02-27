const State = @import("state.zig").State;
const VideoStandardGenerativeFieldType = @import("video_standard_generative_field_type.zig").VideoStandardGenerativeFieldType;

/// Standard Generative Field Configuration of Video
pub const VideoStandardGenerativeField = struct {
    state: State,

    types: ?[]const VideoStandardGenerativeFieldType,

    pub const json_field_names = .{
        .state = "state",
        .types = "types",
    };
};
