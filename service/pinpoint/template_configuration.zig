const Template = @import("template.zig").Template;

/// Specifies the message template to use for the message, for each type of
/// channel.
pub const TemplateConfiguration = struct {
    /// The email template to use for the message.
    email_template: ?Template,

    /// The InApp template to use for the message. The InApp template object is not
    /// supported for SendMessages.
    in_app_template: ?Template,

    /// The push notification template to use for the message.
    push_template: ?Template,

    /// The SMS template to use for the message.
    sms_template: ?Template,

    /// The voice template to use for the message. This object isn't supported for
    /// campaigns.
    voice_template: ?Template,

    pub const json_field_names = .{
        .email_template = "EmailTemplate",
        .in_app_template = "InAppTemplate",
        .push_template = "PushTemplate",
        .sms_template = "SMSTemplate",
        .voice_template = "VoiceTemplate",
    };
};
