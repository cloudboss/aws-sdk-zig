const SMSMessageTemplateContentBody = @import("sms_message_template_content_body.zig").SMSMessageTemplateContentBody;

/// The content of the message template that applies to the SMS channel subtype.
pub const SMSMessageTemplateContent = struct {
    /// The body to use in SMS messages.
    body: ?SMSMessageTemplateContentBody = null,

    pub const json_field_names = .{
        .body = "body",
    };
};
