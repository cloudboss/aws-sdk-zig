const DefaultEmailOptionType = @import("default_email_option_type.zig").DefaultEmailOptionType;

/// The template for the verification message that your user pool delivers to
/// users who
/// set an email address or phone number attribute.
pub const VerificationMessageTemplateType = struct {
    /// The configuration of verification emails to contain a clickable link or a
    /// verification
    /// code.
    ///
    /// For link, your template body must contain link text in the format `{##Click
    /// here##}`. "Click here" in the example is a customizable string. For code,
    /// your
    /// template body must contain a code placeholder in the format `{####}`.
    default_email_option: ?DefaultEmailOptionType,

    /// The template for email messages that Amazon Cognito sends to your users. You
    /// can set an
    /// `EmailMessage` template only if the value of [
    /// EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`. When your [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`, your user pool sends email
    /// messages with your own Amazon SES configuration.
    email_message: ?[]const u8,

    /// The email message template for sending a confirmation link to the user. You
    /// can set an
    /// `EmailMessageByLink` template only if the value of [
    /// EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`. When your [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`, your user pool sends email
    /// messages with your own Amazon SES configuration.
    email_message_by_link: ?[]const u8,

    /// The subject line for the email message template. You can set an
    /// `EmailSubject` template only if the value of [
    /// EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`. When your [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`, your user pool sends email
    /// messages with your own Amazon SES configuration.
    email_subject: ?[]const u8,

    /// The subject line for the email message template for sending a confirmation
    /// link to the
    /// user. You can set an `EmailSubjectByLink` template only if the value of
    /// [
    /// EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`. When your [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is `DEVELOPER`, your user pool sends email
    /// messages with your own Amazon SES configuration.
    email_subject_by_link: ?[]const u8,

    /// The template for SMS messages that Amazon Cognito sends to your users.
    sms_message: ?[]const u8,

    pub const json_field_names = .{
        .default_email_option = "DefaultEmailOption",
        .email_message = "EmailMessage",
        .email_message_by_link = "EmailMessageByLink",
        .email_subject = "EmailSubject",
        .email_subject_by_link = "EmailSubjectByLink",
        .sms_message = "SmsMessage",
    };
};
