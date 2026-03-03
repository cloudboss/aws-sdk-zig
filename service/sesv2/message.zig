const Attachment = @import("attachment.zig").Attachment;
const Body = @import("body.zig").Body;
const MessageHeader = @import("message_header.zig").MessageHeader;
const Content = @import("content.zig").Content;

/// Represents the email message that you're sending. The `Message` object
/// consists of a subject line and a message body.
pub const Message = struct {
    /// The List of attachments to include in your email. All recipients will
    /// receive the same attachments.
    attachments: ?[]const Attachment = null,

    /// The body of the message. You can specify an HTML version of the message, a
    /// text-only
    /// version of the message, or both.
    body: Body,

    /// The list of message headers that will be added to the email message.
    headers: ?[]const MessageHeader = null,

    /// The subject line of the email. The subject line can only contain 7-bit ASCII
    /// characters. However, you can specify non-ASCII characters in the subject
    /// line by using
    /// encoded-word syntax, as described in [RFC
    /// 2047](https://tools.ietf.org/html/rfc2047).
    subject: Content,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .body = "Body",
        .headers = "Headers",
        .subject = "Subject",
    };
};
