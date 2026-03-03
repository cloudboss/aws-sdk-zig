const AudioLogSetting = @import("audio_log_setting.zig").AudioLogSetting;
const TextLogSetting = @import("text_log_setting.zig").TextLogSetting;

/// Configures conversation logging that saves audio, text, and metadata
/// for the conversations with your users.
pub const ConversationLogSettings = struct {
    /// The Amazon S3 settings for logging audio to an S3 bucket.
    audio_log_settings: ?[]const AudioLogSetting = null,

    /// The Amazon CloudWatch Logs settings for logging text and metadata.
    text_log_settings: ?[]const TextLogSetting = null,

    pub const json_field_names = .{
        .audio_log_settings = "audioLogSettings",
        .text_log_settings = "textLogSettings",
    };
};
