const EmailChannelSubtypeParameters = @import("email_channel_subtype_parameters.zig").EmailChannelSubtypeParameters;
const SmsChannelSubtypeParameters = @import("sms_channel_subtype_parameters.zig").SmsChannelSubtypeParameters;
const TelephonyChannelSubtypeParameters = @import("telephony_channel_subtype_parameters.zig").TelephonyChannelSubtypeParameters;
const WhatsAppChannelSubtypeParameters = @import("whats_app_channel_subtype_parameters.zig").WhatsAppChannelSubtypeParameters;

/// ChannelSubtypeParameters for an outbound request
pub const ChannelSubtypeParameters = union(enum) {
    email: ?EmailChannelSubtypeParameters,
    sms: ?SmsChannelSubtypeParameters,
    telephony: ?TelephonyChannelSubtypeParameters,
    whats_app: ?WhatsAppChannelSubtypeParameters,

    pub const json_field_names = .{
        .email = "email",
        .sms = "sms",
        .telephony = "telephony",
        .whats_app = "whatsApp",
    };
};
