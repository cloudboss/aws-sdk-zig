/// A message received at an actor's server-generated email MFA address.
pub const ActorMessage = struct {
    /// The plain-text body of the message, containing the MFA code or verification
    /// link.
    body: ?[]const u8 = null,

    /// The time the message was received.
    received_at: ?i64 = null,

    /// The address the message was sent from.
    sender: ?[]const u8 = null,

    /// The subject line of the message.
    subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
        .received_at = "receivedAt",
        .sender = "sender",
        .subject = "subject",
    };
};
