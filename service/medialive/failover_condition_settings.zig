const AudioSilenceFailoverSettings = @import("audio_silence_failover_settings.zig").AudioSilenceFailoverSettings;
const InputLossFailoverSettings = @import("input_loss_failover_settings.zig").InputLossFailoverSettings;
const VideoBlackFailoverSettings = @import("video_black_failover_settings.zig").VideoBlackFailoverSettings;

/// Settings for one failover condition.
pub const FailoverConditionSettings = struct {
    /// MediaLive will perform a failover if the specified audio selector is silent
    /// for the specified period.
    audio_silence_settings: ?AudioSilenceFailoverSettings,

    /// MediaLive will perform a failover if content is not detected in this input
    /// for the specified period.
    input_loss_settings: ?InputLossFailoverSettings,

    /// MediaLive will perform a failover if content is considered black for the
    /// specified period.
    video_black_settings: ?VideoBlackFailoverSettings,

    pub const json_field_names = .{
        .audio_silence_settings = "AudioSilenceSettings",
        .input_loss_settings = "InputLossSettings",
        .video_black_settings = "VideoBlackSettings",
    };
};
