/// Object specifying a stream’s video configuration, as set up by the
/// broadcaster (usually in
/// an encoder). This is part of the IngestConfigurations object and the
/// deprecated
/// IngestConfiguration object. It is used for monitoring stream health.
pub const VideoConfiguration = struct {
    /// Indicates the degree of required decoder performance for a profile. Normally
    /// this is set
    /// automatically by the encoder. For details, see the H.264 specification.
    avc_level: ?[]const u8 = null,

    /// Indicates to the decoder the requirements for decoding the stream. For
    /// definitions of the
    /// valid values, see the H.264 specification.
    avc_profile: ?[]const u8 = null,

    /// Codec used for the video encoding.
    codec: ?[]const u8 = null,

    /// Software or hardware used to encode the video.
    encoder: ?[]const u8 = null,

    /// Indicates the degree of required decoder performance for a profile. Normally
    /// this is set automatically by the encoder. When an AVC codec is used, this
    /// field has the same value as `avcLevel`.
    level: ?[]const u8 = null,

    /// Indicates to the decoder the requirements for decoding the stream. When an
    /// AVC codec is used, this field has the same value as `avcProfile`.
    profile: ?[]const u8 = null,

    /// The expected ingest bitrate (bits per second). This is configured in the
    /// encoder.
    target_bitrate: i64 = 0,

    /// The expected ingest framerate. This is configured in the encoder.
    target_framerate: i64 = 0,

    /// Name of the video track. If multitrack is not enabled, this is track0 (the
    /// sole track).
    track: ?[]const u8 = null,

    /// Video-resolution height in pixels.
    video_height: i64 = 0,

    /// Video-resolution width in pixels.
    video_width: i64 = 0,

    pub const json_field_names = .{
        .avc_level = "avcLevel",
        .avc_profile = "avcProfile",
        .codec = "codec",
        .encoder = "encoder",
        .level = "level",
        .profile = "profile",
        .target_bitrate = "targetBitrate",
        .target_framerate = "targetFramerate",
        .track = "track",
        .video_height = "videoHeight",
        .video_width = "videoWidth",
    };
};
