const State = @import("state.zig").State;
const AudioStandardGenerativeFieldType = @import("audio_standard_generative_field_type.zig").AudioStandardGenerativeFieldType;

/// Standard Generative Field Configuration of Audio
pub const AudioStandardGenerativeField = struct {
    state: State,

    types: ?[]const AudioStandardGenerativeFieldType,

    pub const json_field_names = .{
        .state = "state",
        .types = "types",
    };
};
