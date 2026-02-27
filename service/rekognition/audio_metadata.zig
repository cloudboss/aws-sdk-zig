/// Metadata information about an audio stream. An array of `AudioMetadata`
/// objects
/// for the audio streams found in a stored video is returned by
/// GetSegmentDetection.
pub const AudioMetadata = struct {
    /// The audio codec used to encode or decode the audio stream.
    codec: ?[]const u8,

    /// The duration of the audio stream in milliseconds.
    duration_millis: ?i64,

    /// The number of audio channels in the segment.
    number_of_channels: ?i64,

    /// The sample rate for the audio stream.
    sample_rate: ?i64,

    pub const json_field_names = .{
        .codec = "Codec",
        .duration_millis = "DurationMillis",
        .number_of_channels = "NumberOfChannels",
        .sample_rate = "SampleRate",
    };
};
