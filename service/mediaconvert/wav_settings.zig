const WavFormat = @import("wav_format.zig").WavFormat;

/// Required when you set Codec to the value WAV.
pub const WavSettings = struct {
    /// Specify Bit depth, in bits per sample, to choose the encoding quality for
    /// this audio track.
    bit_depth: ?i32,

    /// Specify the number of channels in this output audio track. Valid values are
    /// 0, 1, and even numbers up to 64. Choose 0 to follow the number of channels
    /// from your input audio. Otherwise, manually choose from 1, 2, 4, 6, and so
    /// on, up to 64.
    channels: ?i32,

    /// Specify the file format for your wave audio output. To use a RIFF wave
    /// format: Keep the default value, RIFF. If your output audio is likely to
    /// exceed 4GB in file size, or if you otherwise need the extended support of
    /// the RF64 format: Choose RF64. If your player only supports the extensible
    /// wave format: Choose Extensible.
    format: ?WavFormat,

    /// Sample rate in Hz.
    sample_rate: ?i32,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .channels = "Channels",
        .format = "Format",
        .sample_rate = "SampleRate",
    };
};
