const RawMessage = @import("raw_message.zig").RawMessage;
const Message = @import("message.zig").Message;
const Template = @import("template.zig").Template;

/// An object that defines the entire content of the email, including the
/// message headers
/// and the body content. You can create a simple email message, in which you
/// specify the
/// subject and the text and HTML versions of the message body. You can also
/// create raw
/// messages, in which you specify a complete MIME-formatted message. Raw
/// messages can
/// include attachments and custom headers.
pub const EmailContent = struct {
    /// The raw email message. The message has to meet the following criteria:
    ///
    /// * The message has to contain a header and a body, separated by one blank
    /// line.
    ///
    /// * All of the required header fields must be present in the message.
    ///
    /// * Each part of a multipart MIME message must be formatted properly.
    ///
    /// * If you include attachments, they must be in a file format that Amazon
    ///   Pinpoint supports.
    ///
    /// * The entire message must be Base64 encoded.
    ///
    /// * If any of the MIME parts in your message contain content that is outside
    ///   of
    /// the 7-bit ASCII character range, you should encode that content to ensure
    /// that
    /// recipients' email clients render the message properly.
    ///
    /// * The length of any single line of text in the message can't exceed 1,000
    /// characters. This restriction is defined in [RFC
    /// 5321](https://tools.ietf.org/html/rfc5321).
    raw: ?RawMessage = null,

    /// The simple email message. The message consists of a subject and a message
    /// body.
    simple: ?Message = null,

    /// The template to use for the email message.
    template: ?Template = null,

    pub const json_field_names = .{
        .raw = "Raw",
        .simple = "Simple",
        .template = "Template",
    };
};
