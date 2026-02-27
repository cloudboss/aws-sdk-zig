/// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
/// value FLAC.
pub const FlacSettings = struct {
    /// Specify Bit depth (BitDepth), in bits per sample, to choose the encoding
    /// quality for this audio track.
    bit_depth: ?i32,

    /// Specify the number of channels in this output audio track. Valid values are
    /// 0, 1, and even numbers up to 8. Choose 0 to follow the number of channels
    /// from your input audio. Otherwise, manually choose from 1, 2, 4, 6, and 8.
    channels: ?i32,

    /// Sample rate in Hz.
    sample_rate: ?i32,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .channels = "Channels",
        .sample_rate = "SampleRate",
    };
};
