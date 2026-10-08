const NotifyParameters = @import("notify_parameters.zig").NotifyParameters;
const TextParameters = @import("text_parameters.zig").TextParameters;
const VoiceParameters = @import("voice_parameters.zig").VoiceParameters;
const WhatsAppParameters = @import("whats_app_parameters.zig").WhatsAppParameters;

/// The channel-specific parameters used to render and deliver a one-time
/// passcode. Each member configures the parameters for one delivery route.
/// Populate only the channels that a configuration or send request supports. A
/// notify code configuration can carry every channel at once, and a send
/// request resolves to a single route that selects the matching channel at send
/// time.
pub const ChannelParameters = struct {
    /// The parameters for the preapproved notify-template route over the SMS or
    /// voice channels.
    notify: ?NotifyParameters = null,

    /// The parameters for the text channel, which delivers over SMS or RCS.
    text: ?TextParameters = null,

    /// The parameters for the voice channel.
    voice: ?VoiceParameters = null,

    /// The parameters for the WhatsApp channel.
    whats_app: ?WhatsAppParameters = null,

    pub const json_field_names = .{
        .notify = "notify",
        .text = "text",
        .voice = "voice",
        .whats_app = "whatsApp",
    };
};
