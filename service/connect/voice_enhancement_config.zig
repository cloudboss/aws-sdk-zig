const Channel = @import("channel.zig").Channel;
const VoiceEnhancementMode = @import("voice_enhancement_mode.zig").VoiceEnhancementMode;

/// Configuration settings for voice enhancement.
pub const VoiceEnhancementConfig = struct {
    /// The channel for this voice enhancement configuration. **Only `VOICE` is
    /// supported for this data type.**
    channel: Channel,

    /// The voice enhancement mode.
    voice_enhancement_mode: VoiceEnhancementMode,

    pub const json_field_names = .{
        .channel = "Channel",
        .voice_enhancement_mode = "VoiceEnhancementMode",
    };
};
