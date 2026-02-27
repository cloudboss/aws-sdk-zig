const SpectrumConfig = @import("spectrum_config.zig").SpectrumConfig;

/// Information about how AWS Ground Station should configure an antenna for
/// downlink during a contact.
pub const AntennaDownlinkConfig = struct {
    /// Object that describes a spectral `Config`.
    spectrum_config: SpectrumConfig,

    pub const json_field_names = .{
        .spectrum_config = "spectrumConfig",
    };
};
