const DecodeConfig = @import("decode_config.zig").DecodeConfig;
const DemodulationConfig = @import("demodulation_config.zig").DemodulationConfig;
const SpectrumConfig = @import("spectrum_config.zig").SpectrumConfig;

/// Information about how AWS Ground Station should conﬁgure an antenna for
/// downlink demod decode during a contact.
pub const AntennaDownlinkDemodDecodeConfig = struct {
    /// Information about the decode `Config`.
    decode_config: DecodeConfig,

    /// Information about the demodulation `Config`.
    demodulation_config: DemodulationConfig,

    /// Information about the spectral `Config`.
    spectrum_config: SpectrumConfig,

    pub const json_field_names = .{
        .decode_config = "decodeConfig",
        .demodulation_config = "demodulationConfig",
        .spectrum_config = "spectrumConfig",
    };
};
