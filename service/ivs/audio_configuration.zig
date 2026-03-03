/// Object specifying a stream’s audio configuration, as set up by the
/// broadcaster (usually in an encoder). This is part of the
/// IngestConfigurations object and the deprecated IngestConfiguration object.
/// It is used for monitoring stream health.
pub const AudioConfiguration = struct {
    /// Number of audio channels.
    channels: i64 = 0,

    /// Codec used for the audio encoding.
    codec: ?[]const u8 = null,

    /// Number of audio samples recorded per second.
    sample_rate: i64 = 0,

    /// The expected ingest bitrate (bits per second). This is configured in the
    /// encoder.
    target_bitrate: i64 = 0,

    /// Name of the audio track (if the stream has an audio track). If multitrack is
    /// not enabled, this is track0 (the sole track).
    track: ?[]const u8 = null,

    pub const json_field_names = .{
        .channels = "channels",
        .codec = "codec",
        .sample_rate = "sampleRate",
        .target_bitrate = "targetBitrate",
        .track = "track",
    };
};
