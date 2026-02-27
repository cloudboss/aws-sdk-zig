const MessageHeader = @import("message_header.zig").MessageHeader;
const SimpleEmailPart = @import("simple_email_part.zig").SimpleEmailPart;

/// Specifies the contents of an email message, composed of a subject, a text
/// part, and an HTML part.
pub const SimpleEmail = struct {
    /// The list of MessageHeaders for the email. You can have up to 15 Headers.
    headers: ?[]const MessageHeader,

    /// The body of the email message, in HTML format. We recommend using HTML
    /// format for email clients that render HTML content. You can include links,
    /// formatted text, and more in an HTML message.
    html_part: ?SimpleEmailPart,

    /// The subject line, or title, of the email.
    subject: ?SimpleEmailPart,

    /// The body of the email message, in plain text format. We recommend using
    /// plain text format for email clients that don't render HTML content and
    /// clients that are connected to high-latency networks, such as mobile devices.
    text_part: ?SimpleEmailPart,

    pub const json_field_names = .{
        .headers = "Headers",
        .html_part = "HtmlPart",
        .subject = "Subject",
        .text_part = "TextPart",
    };
};
