/// Contains information about a custom verification email template.
pub const CustomVerificationEmailTemplateMetadata = struct {
    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is not successfully verified.
    failure_redirection_url: ?[]const u8 = null,

    /// The email address that the custom verification email is sent from.
    from_email_address: ?[]const u8 = null,

    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is successfully verified.
    success_redirection_url: ?[]const u8 = null,

    /// The name of the custom verification email template.
    template_name: ?[]const u8 = null,

    /// The subject line of the custom verification email.
    template_subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_redirection_url = "FailureRedirectionURL",
        .from_email_address = "FromEmailAddress",
        .success_redirection_url = "SuccessRedirectionURL",
        .template_name = "TemplateName",
        .template_subject = "TemplateSubject",
    };
};
