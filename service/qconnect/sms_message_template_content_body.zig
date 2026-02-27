const MessageTemplateBodyContentProvider = @import("message_template_body_content_provider.zig").MessageTemplateBodyContentProvider;

/// The body to use in SMS messages.
pub const SMSMessageTemplateContentBody = struct {
    /// The message body to use in SMS messages.
    plain_text: ?MessageTemplateBodyContentProvider,

    pub const json_field_names = .{
        .plain_text = "plainText",
    };
};
