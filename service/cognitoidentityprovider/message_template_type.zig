/// The message template structure.
pub const MessageTemplateType = struct {
    /// The message template for email messages. EmailMessage is allowed only if
    /// [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is DEVELOPER.
    email_message: ?[]const u8 = null,

    /// The subject line for email messages. EmailSubject is allowed only if
    /// [EmailSendingAccount](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is DEVELOPER.
    email_subject: ?[]const u8 = null,

    /// The message template for SMS messages.
    sms_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_message = "EmailMessage",
        .email_subject = "EmailSubject",
        .sms_message = "SMSMessage",
    };
};
