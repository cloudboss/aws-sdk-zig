const BandwidthUnits = @import("bandwidth_units.zig").BandwidthUnits;

/// Object that describes the frequency bandwidth.
pub const FrequencyBandwidth = struct {
    /// Frequency bandwidth units.
    units: BandwidthUnits,

    /// Frequency bandwidth value. AWS Ground Station currently has the following
    /// bandwidth limitations:
    ///
    /// * For `AntennaDownlinkDemodDecodeconfig`, valid values are between 125 kHz
    ///   to 650 MHz.
    /// * For `AntennaDownlinkconfig`, valid values are between 10 kHz to 54 MHz.
    /// * For `AntennaUplinkConfig`, valid values are between 10 kHz to 54 MHz.
    value: f64,

    pub const json_field_names = .{
        .units = "units",
        .value = "value",
    };
};
