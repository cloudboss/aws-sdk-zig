const EmissionsUnit = @import("emissions_unit.zig").EmissionsUnit;

/// Represents a carbon emissions quantity with its value and unit of
/// measurement.
pub const Emissions = struct {
    /// The unit of measurement for the emissions value.
    unit: EmissionsUnit,

    /// The numeric value of the emissions quantity.
    value: f64,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
