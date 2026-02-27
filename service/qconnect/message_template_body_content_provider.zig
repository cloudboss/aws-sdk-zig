/// The container of the message template body.
pub const MessageTemplateBodyContentProvider = union(enum) {
    /// The content of the message template.
    content: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
    };
};
