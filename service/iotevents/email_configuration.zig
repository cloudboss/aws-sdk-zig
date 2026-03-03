const EmailContent = @import("email_content.zig").EmailContent;
const EmailRecipients = @import("email_recipients.zig").EmailRecipients;

/// Contains the configuration information of email notifications.
pub const EmailConfiguration = struct {
    /// Contains the subject and message of an email.
    content: ?EmailContent = null,

    /// The email address that sends emails.
    ///
    /// If you use the AWS IoT Events managed AWS Lambda function to manage your
    /// emails, you must [verify
    /// the email address that sends emails in Amazon
    /// SES](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses.html).
    from: []const u8,

    /// Contains the information of one or more recipients who receive the emails.
    ///
    /// You must [add the users that receive emails to your AWS SSO
    /// store](https://docs.aws.amazon.com/singlesignon/latest/userguide/addusers.html).
    recipients: EmailRecipients,

    pub const json_field_names = .{
        .content = "content",
        .from = "from",
        .recipients = "recipients",
    };
};
