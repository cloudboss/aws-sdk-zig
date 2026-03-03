/// The message details.
pub const FileValidationMessage = struct {
    /// The message content.
    content: ?[]const u8 = null,

    /// The message title.
    title: ?[]const u8 = null,

    /// The message type.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .title = "title",
        .@"type" = "type",
    };
};
