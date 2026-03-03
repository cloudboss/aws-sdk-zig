/// Instructions for using a tool.
pub const ToolInstruction = struct {
    /// Examples for using the tool.
    examples: ?[]const []const u8 = null,

    /// The instruction text for the tool.
    instruction: ?[]const u8 = null,

    pub const json_field_names = .{
        .examples = "examples",
        .instruction = "instruction",
    };
};
