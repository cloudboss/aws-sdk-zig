const DeliveryMethod = @import("delivery_method.zig").DeliveryMethod;
const EmailSettings = @import("email_settings.zig").EmailSettings;
const SmsSettings = @import("sms_settings.zig").SmsSettings;

/// Updates the configuration of the email or SMS message for the auth resource
/// configured for your Amplify project.
pub const UpdateBackendAuthVerificationMessageConfig = struct {
    /// The type of verification message to send.
    delivery_method: DeliveryMethod,

    /// The settings for the email message.
    email_settings: ?EmailSettings = null,

    /// The settings for the SMS message.
    sms_settings: ?SmsSettings = null,

    pub const json_field_names = .{
        .delivery_method = "DeliveryMethod",
        .email_settings = "EmailSettings",
        .sms_settings = "SmsSettings",
    };
};
