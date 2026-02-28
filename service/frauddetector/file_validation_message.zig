/// The message details.
pub const FileValidationMessage = struct {
    /// The message content.
    content: ?[]const u8,

    /// The message title.
    title: ?[]const u8,

    /// The message type.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .title = "title",
        .@"type" = "type",
    };
};
