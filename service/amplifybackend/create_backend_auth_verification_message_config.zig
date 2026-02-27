const DeliveryMethod = @import("delivery_method.zig").DeliveryMethod;
const EmailSettings = @import("email_settings.zig").EmailSettings;
const SmsSettings = @import("sms_settings.zig").SmsSettings;

/// Creates an email or SMS verification message for the auth resource
/// configured for your Amplify project.
pub const CreateBackendAuthVerificationMessageConfig = struct {
    /// The type of verification message to send.
    delivery_method: DeliveryMethod,

    /// The settings for the email message.
    email_settings: ?EmailSettings,

    /// The settings for the SMS message.
    sms_settings: ?SmsSettings,

    pub const json_field_names = .{
        .delivery_method = "DeliveryMethod",
        .email_settings = "EmailSettings",
        .sms_settings = "SmsSettings",
    };
};
