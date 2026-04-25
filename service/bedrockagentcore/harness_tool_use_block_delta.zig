/// Delta payload for tool use input.
pub const HarnessToolUseBlockDelta = struct {
    /// The partial JSON input for the tool call.
    input: []const u8,

    pub const json_field_names = .{
        .input = "input",
    };
};
