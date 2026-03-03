const AudioLogDestination = @import("audio_log_destination.zig").AudioLogDestination;

/// Settings for logging audio of conversations between Amazon Lex and a
/// user. You specify whether to log audio and the Amazon S3 bucket where
/// the audio file is stored.
pub const AudioLogSetting = struct {
    destination: AudioLogDestination,

    /// Determines whether audio logging in enabled for the bot.
    enabled: bool = false,

    /// The option to enable selective conversation log capture for audio.
    selective_logging_enabled: ?bool = null,

    pub const json_field_names = .{
        .destination = "destination",
        .enabled = "enabled",
        .selective_logging_enabled = "selectiveLoggingEnabled",
    };
};
