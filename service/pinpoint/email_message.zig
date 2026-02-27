const aws = @import("aws");

const RawEmail = @import("raw_email.zig").RawEmail;
const SimpleEmail = @import("simple_email.zig").SimpleEmail;

/// Specifies the default settings and content for a one-time email message
/// that's sent directly to an endpoint.
pub const EmailMessage = struct {
    /// The body of the email message.
    body: ?[]const u8,

    /// The email address to forward bounces and complaints to, if feedback
    /// forwarding is enabled.
    feedback_forwarding_address: ?[]const u8,

    /// The verified email address to send the email message from. The default value
    /// is the FromAddress specified for the email channel.
    from_address: ?[]const u8,

    /// The email message, represented as a raw MIME message.
    raw_email: ?RawEmail,

    /// The reply-to email address(es) for the email message. If a recipient replies
    /// to the email, each reply-to address receives the reply.
    reply_to_addresses: ?[]const []const u8,

    /// The email message, composed of a subject, a text part, and an HTML part.
    simple_email: ?SimpleEmail,

    /// The default message variables to use in the email message. You can override
    /// the default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .body = "Body",
        .feedback_forwarding_address = "FeedbackForwardingAddress",
        .from_address = "FromAddress",
        .raw_email = "RawEmail",
        .reply_to_addresses = "ReplyToAddresses",
        .simple_email = "SimpleEmail",
        .substitutions = "Substitutions",
    };
};
