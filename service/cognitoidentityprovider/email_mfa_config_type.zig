/// Sets or shows configuration for user pool email message MFA and sign-in with
/// one-time
/// passwords (OTPs). Includes the subject and body of the email message
/// template for
/// sign-in and MFA messages. To activate this setting, your user pool must be
/// in the [
/// Essentials
/// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
pub const EmailMfaConfigType = struct {
    /// The template for the email messages that your user pool sends to users with
    /// codes for
    /// MFA and sign-in with email OTPs. The message must contain the `{####}`
    /// placeholder. In the message, Amazon Cognito replaces this placeholder with
    /// the code. If you
    /// don't provide this parameter, Amazon Cognito sends messages in the default
    /// format.
    message: ?[]const u8 = null,

    /// The subject of the email messages that your user pool sends to users with
    /// codes for
    /// MFA and email OTP sign-in.
    subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .subject = "Subject",
    };
};
