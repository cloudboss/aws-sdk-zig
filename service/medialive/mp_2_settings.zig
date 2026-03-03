const Mp2CodingMode = @import("mp_2_coding_mode.zig").Mp2CodingMode;

/// Mp2 Settings
pub const Mp2Settings = struct {
    /// Average bitrate in bits/second.
    bitrate: ?f64 = null,

    /// The MPEG2 Audio coding mode. Valid values are codingMode10 (for mono) or
    /// codingMode20 (for stereo).
    coding_mode: ?Mp2CodingMode = null,

    /// Sample rate in Hz.
    sample_rate: ?f64 = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .coding_mode = "CodingMode",
        .sample_rate = "SampleRate",
    };
};
