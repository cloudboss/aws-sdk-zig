/// A block of content in a user message.
pub const UserMessageBlock = union(enum) {
    /// Text content from the user.
    text: ?[]const u8,
    /// Tool execution result provided by the user.
    tool_result: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
        .tool_result = "toolResult",
    };
};
