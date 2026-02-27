const SmsConfigurationType = @import("sms_configuration_type.zig").SmsConfigurationType;

/// The configuration of multi-factor authentication (MFA) with SMS messages in
/// a user
/// pool.
pub const SmsMfaConfigType = struct {
    /// The SMS authentication message that will be sent to users with the code they
    /// must sign
    /// in with. The message must contain the `{####}` placeholder. Your user pool
    /// replaces the placeholder with the MFA code. If this parameter isn't
    /// provided, your user
    /// pool sends a default message.
    sms_authentication_message: ?[]const u8,

    /// User pool configuration for delivery of SMS messages with Amazon Simple
    /// Notification Service. To send SMS
    /// messages with Amazon SNS in the Amazon Web Services Region that you want,
    /// the Amazon Cognito user pool uses an
    /// Identity and Access Management (IAM) role in your Amazon Web Services
    /// account.
    ///
    /// You can set `SmsConfiguration` in `CreateUserPool` and `
    /// UpdateUserPool`, or in `SetUserPoolMfaConfig`.
    sms_configuration: ?SmsConfigurationType,

    pub const json_field_names = .{
        .sms_authentication_message = "SmsAuthenticationMessage",
        .sms_configuration = "SmsConfiguration",
    };
};
