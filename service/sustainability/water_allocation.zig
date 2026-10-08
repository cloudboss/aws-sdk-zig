const WaterAllocationUnit = @import("water_allocation_unit.zig").WaterAllocationUnit;

/// Represents a water allocation quantity with its value and unit of
/// measurement.
pub const WaterAllocation = struct {
    /// The unit of measurement for the allocation value.
    unit: WaterAllocationUnit,

    /// The numeric value of the allocation quantity.
    value: f64,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
