const WavCodingMode = @import("wav_coding_mode.zig").WavCodingMode;

/// Wav Settings
pub const WavSettings = struct {
    /// Bits per sample.
    bit_depth: ?f64,

    /// The audio coding mode for the WAV audio. The mode determines the number of
    /// channels in the audio.
    coding_mode: ?WavCodingMode,

    /// Sample rate in Hz.
    sample_rate: ?f64,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .coding_mode = "CodingMode",
        .sample_rate = "SampleRate",
    };
};
