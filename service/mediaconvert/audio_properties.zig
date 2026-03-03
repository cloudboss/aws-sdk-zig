const FrameRate = @import("frame_rate.zig").FrameRate;

/// Details about the media file's audio track.
pub const AudioProperties = struct {
    /// The bit depth of the audio track.
    bit_depth: ?i32 = null,

    /// The bit rate of the audio track, in bits per second.
    bit_rate: ?i64 = null,

    /// The number of audio channels in the audio track.
    channels: ?i32 = null,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    frame_rate: ?FrameRate = null,

    /// The language code of the audio track, in three character ISO 639-3 format.
    language_code: ?[]const u8 = null,

    /// The sample rate of the audio track.
    sample_rate: ?i32 = null,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .bit_rate = "BitRate",
        .channels = "Channels",
        .frame_rate = "FrameRate",
        .language_code = "LanguageCode",
        .sample_rate = "SampleRate",
    };
};
