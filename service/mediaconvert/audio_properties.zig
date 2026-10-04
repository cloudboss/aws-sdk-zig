const FrameRate = @import("frame_rate.zig").FrameRate;

/// Details about the media file's audio track.
pub const AudioProperties = struct {
    /// The bit depth of the audio track. This value is exact for PCM and FLAC
    /// audio. For lossy codecs, such as AAC, AC-3, and E-AC-3, it is a nominal
    /// value and should be treated as approximate.
    bit_depth: ?i32 = null,

    /// The bit rate of the audio track, in bits per second.
    bit_rate: ?i64 = null,

    /// The audio channel layout of the track, such as "mono", "stereo", "5.1", or
    /// "7.1". Object-based or immersive audio is reported as "5.1.4" or "7.1.4".
    /// The layout is exact for AC-3 and E-AC-3 audio. For other codecs, it is
    /// inferred from the channel count and should be treated as approximate.
    channel_layout: ?[]const u8 = null,

    /// The number of audio channels in the audio track.
    channels: ?i32 = null,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    frame_rate: ?FrameRate = null,

    /// The language code of the audio track, in three character ISO 639-3 format.
    language_code: ?[]const u8 = null,

    /// The number of audio objects in an object-based or immersive audio track.
    /// This field is present for codecs that support object-based audio, such as
    /// E-AC-3 with Joint Object Coding (JOC) or IAMF. This field is null when the
    /// audio track does not contain object-based audio metadata.
    object_count: ?i32 = null,

    /// The sample rate of the audio track.
    sample_rate: ?i32 = null,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .bit_rate = "BitRate",
        .channel_layout = "ChannelLayout",
        .channels = "Channels",
        .frame_rate = "FrameRate",
        .language_code = "LanguageCode",
        .object_count = "ObjectCount",
        .sample_rate = "SampleRate",
    };
};
