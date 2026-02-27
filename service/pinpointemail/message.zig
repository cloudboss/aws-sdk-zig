const Body = @import("body.zig").Body;
const Content = @import("content.zig").Content;

/// Represents the email message that you're sending. The `Message` object
/// consists of a subject line and a message body.
pub const Message = struct {
    /// The body of the message. You can specify an HTML version of the message, a
    /// text-only
    /// version of the message, or both.
    body: Body,

    /// The subject line of the email. The subject line can only contain 7-bit ASCII
    /// characters. However, you can specify non-ASCII characters in the subject
    /// line by using
    /// encoded-word syntax, as described in [RFC
    /// 2047](https://tools.ietf.org/html/rfc2047).
    subject: Content,

    pub const json_field_names = .{
        .body = "Body",
        .subject = "Subject",
    };
};
