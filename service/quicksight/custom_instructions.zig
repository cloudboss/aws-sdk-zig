/// Instructions that provide additional guidance and context for response
/// generation.
pub const CustomInstructions = struct {
    /// A text field for providing additional guidance or context for response
    /// generation.
    custom_instructions_string: []const u8,

    pub const json_field_names = .{
        .custom_instructions_string = "CustomInstructionsString",
    };
};
