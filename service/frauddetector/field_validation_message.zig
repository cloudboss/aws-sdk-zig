/// The message details.
pub const FieldValidationMessage = struct {
    /// The message content.
    content: ?[]const u8 = null,

    /// The field name.
    field_name: ?[]const u8 = null,

    /// The message ID.
    identifier: ?[]const u8 = null,

    /// The message title.
    title: ?[]const u8 = null,

    /// The message type.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .field_name = "fieldName",
        .identifier = "identifier",
        .title = "title",
        .@"type" = "type",
    };
};
