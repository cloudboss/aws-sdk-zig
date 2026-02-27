const MediaEncoding = @import("media_encoding.zig").MediaEncoding;
const StreamConfiguration = @import("stream_configuration.zig").StreamConfiguration;

/// The runtime configuration settings for the Kinesis video stream source.
pub const KinesisVideoStreamSourceRuntimeConfiguration = struct {
    /// Specifies the encoding of your input audio. Supported format: PCM (only
    /// signed 16-bit little-endian audio formats, which does not include WAV)
    ///
    /// For more information, see [Media
    /// formats](https://docs.aws.amazon.com/transcribe/latest/dg/how-input.html#how-input-audio) in the *Amazon Transcribe Developer Guide*.
    media_encoding: MediaEncoding,

    /// The sample rate of the input audio (in hertz). Low-quality audio, such as
    /// telephone
    /// audio, is typically around 8,000 Hz. High-quality audio typically ranges
    /// from 16,000 Hz to
    /// 48,000 Hz. Note that the sample rate you specify must match that of your
    /// audio.
    ///
    /// Valid Range: Minimum value of 8000. Maximum value of 48000.
    media_sample_rate: i32,

    /// The streams in the source runtime configuration of a Kinesis video stream.
    streams: []const StreamConfiguration,

    pub const json_field_names = .{
        .media_encoding = "MediaEncoding",
        .media_sample_rate = "MediaSampleRate",
        .streams = "Streams",
    };
};
