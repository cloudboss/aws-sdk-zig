const EmailMessageTemplateContentBody = @import("email_message_template_content_body.zig").EmailMessageTemplateContentBody;
const EmailHeader = @import("email_header.zig").EmailHeader;

/// The content of the message template that applies to the email channel
/// subtype.
pub const EmailMessageTemplateContent = struct {
    /// The body to use in email messages.
    body: ?EmailMessageTemplateContentBody = null,

    /// The email headers to include in email messages.
    headers: ?[]const EmailHeader = null,

    /// The subject line, or title, to use in email messages.
    subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
        .headers = "headers",
        .subject = "subject",
    };
};
