const State = @import("state.zig").State;
const ImageStandardGenerativeFieldType = @import("image_standard_generative_field_type.zig").ImageStandardGenerativeFieldType;

/// Standard Generative Field Configuration of Image
pub const ImageStandardGenerativeField = struct {
    state: State,

    types: ?[]const ImageStandardGenerativeFieldType = null,

    pub const json_field_names = .{
        .state = "state",
        .types = "types",
    };
};
