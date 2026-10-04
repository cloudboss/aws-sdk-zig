/// Contains the email addresses used for email-based domain validation.
pub const EmailValidationChallenge = struct {
    /// The domain name that ACM uses to send validation emails.
    validation_domain: ?[]const u8 = null,

    /// A list of email addresses that ACM uses to send domain validation emails.
    validation_emails: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .validation_domain = "ValidationDomain",
        .validation_emails = "ValidationEmails",
    };
};
