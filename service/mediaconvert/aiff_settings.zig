/// Required when you set Codec to the value AIFF.
pub const AiffSettings = struct {
    /// Specify Bit depth, in bits per sample, to choose the encoding quality for
    /// this audio track.
    bit_depth: ?i32 = null,

    /// Specify the number of channels in this output audio track. Valid values are
    /// 0, 1, and even numbers up to 64. Choose 0 to follow the number of channels
    /// from your input audio. Otherwise, manually choose from 1, 2, 4, 6, and so
    /// on, up to 64.
    channels: ?i32 = null,

    /// Sample rate in Hz.
    sample_rate: ?i32 = null,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .channels = "Channels",
        .sample_rate = "SampleRate",
    };
};
