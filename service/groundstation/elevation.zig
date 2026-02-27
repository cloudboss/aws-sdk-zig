const AngleUnits = @import("angle_units.zig").AngleUnits;

/// Elevation angle of the satellite in the sky during a contact.
pub const Elevation = struct {
    /// Elevation angle units.
    unit: AngleUnits,

    /// Elevation angle value.
    value: f64,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
