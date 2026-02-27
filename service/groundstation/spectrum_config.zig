const FrequencyBandwidth = @import("frequency_bandwidth.zig").FrequencyBandwidth;
const Frequency = @import("frequency.zig").Frequency;
const Polarization = @import("polarization.zig").Polarization;

/// Object that describes a spectral `Config`.
pub const SpectrumConfig = struct {
    /// Bandwidth of a spectral `Config`. AWS Ground Station currently has the
    /// following bandwidth limitations:
    ///
    /// * For `AntennaDownlinkDemodDecodeconfig`, valid values are between 125 kHz
    ///   to 650 MHz.
    /// * For `AntennaDownlinkconfig` valid values are between 10 kHz to 54 MHz.
    /// * For `AntennaUplinkConfig`, valid values are between 10 kHz to 54 MHz.
    bandwidth: FrequencyBandwidth,

    /// Center frequency of a spectral `Config`. Valid values are between 2200 to
    /// 2300 MHz and 7750 to 8400 MHz for downlink and 2025 to 2120 MHz for uplink.
    center_frequency: Frequency,

    /// Polarization of a spectral `Config`. Capturing both `"RIGHT_HAND"` and
    /// `"LEFT_HAND"` polarization requires two separate configs.
    polarization: Polarization = "NONE",

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .center_frequency = "centerFrequency",
        .polarization = "polarization",
    };
};
