const EmailChannelSubtypeConfig = @import("email_channel_subtype_config.zig").EmailChannelSubtypeConfig;
const SmsChannelSubtypeConfig = @import("sms_channel_subtype_config.zig").SmsChannelSubtypeConfig;
const TelephonyChannelSubtypeConfig = @import("telephony_channel_subtype_config.zig").TelephonyChannelSubtypeConfig;
const WhatsAppChannelSubtypeConfig = @import("whats_app_channel_subtype_config.zig").WhatsAppChannelSubtypeConfig;

/// Campaign Channel Subtype config
pub const ChannelSubtypeConfig = struct {
    email: ?EmailChannelSubtypeConfig,

    sms: ?SmsChannelSubtypeConfig,

    telephony: ?TelephonyChannelSubtypeConfig,

    whats_app: ?WhatsAppChannelSubtypeConfig,

    pub const json_field_names = .{
        .email = "email",
        .sms = "sms",
        .telephony = "telephony",
        .whats_app = "whatsApp",
    };
};
