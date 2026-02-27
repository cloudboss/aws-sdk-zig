/// Contains the subject and message of an email.
pub const EmailContent = struct {
    /// The message that you want to send. The message can be up to 200 characters.
    additional_message: ?[]const u8,

    /// The subject of the email.
    subject: ?[]const u8,

    pub const json_field_names = .{
        .additional_message = "additionalMessage",
        .subject = "subject",
    };
};
