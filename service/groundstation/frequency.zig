const FrequencyUnits = @import("frequency_units.zig").FrequencyUnits;

/// Object that describes the frequency.
pub const Frequency = struct {
    /// Frequency units.
    units: FrequencyUnits,

    /// Frequency value. Valid values are between 2200 to 2300 MHz and 7750 to 8400
    /// MHz for downlink and 2025 to 2120 MHz for uplink.
    value: f64,

    pub const json_field_names = .{
        .units = "units",
        .value = "value",
    };
};
