/// A block of content in an assistant message.
pub const AssistantMessageBlock = union(enum) {
    /// Text content from the assistant.
    text: ?[]const u8,
    /// Tool use request from the assistant.
    tool_use: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
        .tool_use = "toolUse",
    };
};
