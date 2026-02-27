/// The configuration for the email sent when an app user forgets their
/// password.
pub const EmailSettings = struct {
    /// The contents of the email message.
    email_message: ?[]const u8,

    /// The contents of the subject line of the email message.
    email_subject: ?[]const u8,

    pub const json_field_names = .{
        .email_message = "EmailMessage",
        .email_subject = "EmailSubject",
    };
};
