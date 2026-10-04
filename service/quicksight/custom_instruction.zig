const InlineCustomInstruction = @import("inline_custom_instruction.zig").InlineCustomInstruction;

/// A custom instruction that provides guidance on how the dataset should be
/// consumed.
pub const CustomInstruction = struct {
    /// An inline custom instruction containing text and optional uploaded document
    /// metadata.
    inline_custom_instruction: ?InlineCustomInstruction = null,

    pub const json_field_names = .{
        .inline_custom_instruction = "InlineCustomInstruction",
    };
};
