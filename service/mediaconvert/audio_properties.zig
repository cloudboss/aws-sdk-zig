const FrameRate = @import("frame_rate.zig").FrameRate;

/// Details about the media file's audio track.
pub const AudioProperties = struct {
    /// The bit depth of the audio track.
    bit_depth: ?i32,

    /// The bit rate of the audio track, in bits per second.
    bit_rate: ?i64,

    /// The number of audio channels in the audio track.
    channels: ?i32,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    frame_rate: ?FrameRate,

    /// The language code of the audio track, in three character ISO 639-3 format.
    language_code: ?[]const u8,

    /// The sample rate of the audio track.
    sample_rate: ?i32,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .bit_rate = "BitRate",
        .channels = "Channels",
        .frame_rate = "FrameRate",
        .language_code = "LanguageCode",
        .sample_rate = "SampleRate",
    };
};
