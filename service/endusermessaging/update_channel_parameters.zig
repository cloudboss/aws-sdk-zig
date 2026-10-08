const UpdateNotifyParameters = @import("update_notify_parameters.zig").UpdateNotifyParameters;
const UpdateTextParameters = @import("update_text_parameters.zig").UpdateTextParameters;
const UpdateVoiceParameters = @import("update_voice_parameters.zig").UpdateVoiceParameters;
const UpdateWhatsAppParameters = @import("update_whats_app_parameters.zig").UpdateWhatsAppParameters;

/// The updated channel-specific parameters used only when you update a notify
/// code configuration. When you omit a channel, that channel's parameters
/// remain unchanged. When you supply a channel, you can clear individual fields
/// by using the empty-string or empty-map sentinel on a member, or drop the
/// whole channel's parameters by clearing every member. These sentinels apply
/// only when you update a configuration; a create request rejects empty values
/// with a validation error.
pub const UpdateChannelParameters = struct {
    /// The notify-template-route parameters to update. Omit this member to leave
    /// them unchanged.
    notify: ?UpdateNotifyParameters = null,

    /// The text-channel parameters to update. Omit this member to leave the
    /// text-channel parameters unchanged.
    text: ?UpdateTextParameters = null,

    /// The voice-channel parameters to update. Omit this member to leave the
    /// voice-channel parameters unchanged.
    voice: ?UpdateVoiceParameters = null,

    /// The WhatsApp-channel parameters to update. Omit this member to leave the
    /// WhatsApp-channel parameters unchanged.
    whats_app: ?UpdateWhatsAppParameters = null,

    pub const json_field_names = .{
        .notify = "notify",
        .text = "text",
        .voice = "voice",
        .whats_app = "whatsApp",
    };
};
