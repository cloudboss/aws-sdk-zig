const SilentAudio = @import("silent_audio.zig").SilentAudio;

/// Specifies the configuration for audio stream metrics monitoring.
pub const AudioMonitoringSetting = struct {
    /// Detects periods of silence.
    silent_audio: ?SilentAudio,

    pub const json_field_names = .{
        .silent_audio = "SilentAudio",
    };
};
