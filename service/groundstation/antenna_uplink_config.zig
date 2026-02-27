const UplinkSpectrumConfig = @import("uplink_spectrum_config.zig").UplinkSpectrumConfig;
const Eirp = @import("eirp.zig").Eirp;

/// Information about the uplink `Config` of an antenna.
pub const AntennaUplinkConfig = struct {
    /// Information about the uplink spectral `Config`.
    spectrum_config: UplinkSpectrumConfig,

    /// EIRP of the target.
    target_eirp: Eirp,

    /// Whether or not uplink transmit is disabled.
    transmit_disabled: ?bool,

    pub const json_field_names = .{
        .spectrum_config = "spectrumConfig",
        .target_eirp = "targetEirp",
        .transmit_disabled = "transmitDisabled",
    };
};
