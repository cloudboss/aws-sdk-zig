const AudioChannelsOption = @import("audio_channels_option.zig").AudioChannelsOption;

/// The media pipeline's RTMP configuration object.
pub const LiveConnectorRTMPConfiguration = struct {
    /// The audio channels set for the RTMP configuration
    audio_channels: ?AudioChannelsOption,

    /// The audio sample rate set for the RTMP configuration. Default: 48000.
    audio_sample_rate: ?[]const u8,

    /// The URL of the RTMP configuration.
    url: []const u8,

    pub const json_field_names = .{
        .audio_channels = "AudioChannels",
        .audio_sample_rate = "AudioSampleRate",
        .url = "Url",
    };
};
