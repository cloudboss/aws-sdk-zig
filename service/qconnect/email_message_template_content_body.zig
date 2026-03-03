const MessageTemplateBodyContentProvider = @import("message_template_body_content_provider.zig").MessageTemplateBodyContentProvider;

/// The body to use in email messages.
pub const EmailMessageTemplateContentBody = struct {
    /// The message body, in HTML format, to use in email messages that are based on
    /// the message template. We recommend using HTML format for email clients that
    /// render HTML content. You can include links, formatted text, and more in an
    /// HTML message.
    html: ?MessageTemplateBodyContentProvider = null,

    /// The message body, in plain text format, to use in email messages that are
    /// based on the message template. We recommend using plain text format for
    /// email clients that don't render HTML content and clients that are connected
    /// to high-latency networks, such as mobile devices.
    plain_text: ?MessageTemplateBodyContentProvider = null,

    pub const json_field_names = .{
        .html = "html",
        .plain_text = "plainText",
    };
};
