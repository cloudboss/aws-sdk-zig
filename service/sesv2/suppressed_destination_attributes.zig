/// An object that contains additional attributes that are related an email
/// address that
/// is on the suppression list for your account.
pub const SuppressedDestinationAttributes = struct {
    /// A unique identifier that's generated when an email address is added to the
    /// suppression
    /// list for your account.
    feedback_id: ?[]const u8,

    /// The unique identifier of the email message that caused the email address to
    /// be added
    /// to the suppression list for your account.
    message_id: ?[]const u8,

    pub const json_field_names = .{
        .feedback_id = "FeedbackId",
        .message_id = "MessageId",
    };
};
