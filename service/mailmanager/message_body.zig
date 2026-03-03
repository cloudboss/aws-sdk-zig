/// The textual body content of an email message.
pub const MessageBody = struct {
    /// The HTML body content of the message.
    html: ?[]const u8 = null,

    /// A flag indicating if the email was malformed.
    message_malformed: ?bool = null,

    /// The plain text body content of the message.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .html = "Html",
        .message_malformed = "MessageMalformed",
        .text = "Text",
    };
};
