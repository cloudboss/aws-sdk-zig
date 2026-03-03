const Envelope = @import("envelope.zig").Envelope;

/// A result row containing metadata for an archived email message.
pub const Row = struct {
    /// The unique identifier of the archived message.
    archived_message_id: ?[]const u8 = null,

    /// The email addresses in the CC header.
    cc: ?[]const u8 = null,

    /// The date the email was sent.
    date: ?[]const u8 = null,

    /// The SMTP envelope information of the email.
    envelope: ?Envelope = null,

    /// The email address of the sender.
    from: ?[]const u8 = null,

    /// A flag indicating if the email has attachments.
    has_attachments: ?bool = null,

    /// The ID of the ingress endpoint through which the email was received.
    ingress_point_id: ?[]const u8 = null,

    /// The email message ID this is a reply to.
    in_reply_to: ?[]const u8 = null,

    /// The unique message ID of the email.
    message_id: ?[]const u8 = null,

    /// The received headers from the email delivery path.
    received_headers: ?[]const []const u8 = null,

    /// The timestamp of when the email was received.
    received_timestamp: ?i64 = null,

    /// The name of the host from which the email was received.
    sender_hostname: ?[]const u8 = null,

    /// * Mail archived with Mail Manager: The IP address of the client that
    ///   connects to the ingress endpoint.
    /// * Mail sent through a configuration set with the archiving option enabled:
    ///   The IP address of the client that makes the SendEmail API call.
    sender_ip_address: ?[]const u8 = null,

    /// Specifies the archived email source, identified by either a Rule Set's ARN
    /// with an Archive action, or a Configuration Set's Archive ARN.
    source_arn: ?[]const u8 = null,

    /// The subject header value of the email.
    subject: ?[]const u8 = null,

    /// The email addresses in the To header.
    to: ?[]const u8 = null,

    /// The user agent that sent the email.
    x_mailer: ?[]const u8 = null,

    /// The original user agent that sent the email.
    x_original_mailer: ?[]const u8 = null,

    /// The priority level of the email.
    x_priority: ?[]const u8 = null,

    pub const json_field_names = .{
        .archived_message_id = "ArchivedMessageId",
        .cc = "Cc",
        .date = "Date",
        .envelope = "Envelope",
        .from = "From",
        .has_attachments = "HasAttachments",
        .ingress_point_id = "IngressPointId",
        .in_reply_to = "InReplyTo",
        .message_id = "MessageId",
        .received_headers = "ReceivedHeaders",
        .received_timestamp = "ReceivedTimestamp",
        .sender_hostname = "SenderHostname",
        .sender_ip_address = "SenderIpAddress",
        .source_arn = "SourceArn",
        .subject = "Subject",
        .to = "To",
        .x_mailer = "XMailer",
        .x_original_mailer = "XOriginalMailer",
        .x_priority = "XPriority",
    };
};
