/// Set of options which defines notification preferences of given action.
pub const NotificationOptions = struct {
    /// Text value to be included in the email body.
    email_message: ?[]const u8,

    /// Boolean value to indicate an email notification should be sent to the
    /// recipients.
    send_email: bool = false,

    pub const json_field_names = .{
        .email_message = "EmailMessage",
        .send_email = "SendEmail",
    };
};
