/// The delta for a tool use block.
pub const ToolUseBlockDelta = struct {
    /// The input for a requested tool.
    input: []const u8,

    pub const json_field_names = .{
        .input = "input",
    };
};
