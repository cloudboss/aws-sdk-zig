/// Provides information about a request to create a message template.
pub const TemplateCreateMessageBody = struct {
    /// The Amazon Resource Name (ARN) of the message template that was created.
    arn: ?[]const u8 = null,

    /// The message that's returned from the API for the request to create the
    /// message template.
    message: ?[]const u8 = null,

    /// The unique identifier for the request to create the message template.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .message = "Message",
        .request_id = "RequestID",
    };
};
