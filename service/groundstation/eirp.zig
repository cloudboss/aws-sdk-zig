const EirpUnits = @import("eirp_units.zig").EirpUnits;

/// Object that represents EIRP.
pub const Eirp = struct {
    /// Units of an EIRP.
    units: EirpUnits,

    /// Value of an EIRP. Valid values are between 20.0 to 50.0 dBW.
    value: f64,

    pub const json_field_names = .{
        .units = "units",
        .value = "value",
    };
};
