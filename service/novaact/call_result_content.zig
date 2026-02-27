/// Content returned from a tool call execution.
pub const CallResultContent = union(enum) {
    /// Text content returned from the tool execution.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
