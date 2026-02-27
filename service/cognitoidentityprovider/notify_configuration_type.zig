const NotifyEmailType = @import("notify_email_type.zig").NotifyEmailType;

/// The configuration for Amazon SES email messages that threat protection sends
/// to a user when
/// your adaptive authentication automated response has a *Notify*
/// action.
pub const NotifyConfigurationType = struct {
    /// The template for the email message that your user pool sends when a detected
    /// risk
    /// event is blocked.
    block_email: ?NotifyEmailType,

    /// The email address that sends the email message. The address must be either
    /// individually verified with Amazon Simple Email Service, or from a domain
    /// that has been verified with
    /// Amazon SES.
    from: ?[]const u8,

    /// The template for the email message that your user pool sends when MFA is
    /// challenged in
    /// response to a detected risk.
    mfa_email: ?NotifyEmailType,

    /// The template for the email message that your user pool sends when no action
    /// is taken
    /// in response to a detected risk.
    no_action_email: ?NotifyEmailType,

    /// The reply-to email address of an email template.
    reply_to: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the identity that is associated with the
    /// sending
    /// authorization policy. This identity permits Amazon Cognito to send for the
    /// email address
    /// specified in the `From` parameter.
    source_arn: []const u8,

    pub const json_field_names = .{
        .block_email = "BlockEmail",
        .from = "From",
        .mfa_email = "MfaEmail",
        .no_action_email = "NoActionEmail",
        .reply_to = "ReplyTo",
        .source_arn = "SourceArn",
    };
};
