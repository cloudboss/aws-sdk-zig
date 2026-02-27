const DeliveryMethod = @import("delivery_method.zig").DeliveryMethod;
const EmailSettings = @import("email_settings.zig").EmailSettings;
const SmsSettings = @import("sms_settings.zig").SmsSettings;

/// **(DEPRECATED)** Describes the forgot password policy for authenticating
/// into the Amplify app.
pub const UpdateBackendAuthForgotPasswordConfig = struct {
    /// **(DEPRECATED)** Describes which mode to use (either SMS or email) to
    /// deliver messages to app users that want to recover their password.
    delivery_method: ?DeliveryMethod,

    /// **(DEPRECATED)** The configuration for the email sent when an app user
    /// forgets their password.
    email_settings: ?EmailSettings,

    /// **(DEPRECATED)** The configuration for the SMS message sent when an Amplify
    /// app user forgets their password.
    sms_settings: ?SmsSettings,

    pub const json_field_names = .{
        .delivery_method = "DeliveryMethod",
        .email_settings = "EmailSettings",
        .sms_settings = "SmsSettings",
    };
};
