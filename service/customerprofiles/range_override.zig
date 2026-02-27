const RangeUnit = @import("range_unit.zig").RangeUnit;

/// Overrides the original range on a calculated attribute definition.
pub const RangeOverride = struct {
    /// The end time of when to include objects.
    end: i32 = 0,

    /// The start time of when to include objects.
    start: i32 = 366,

    /// The unit for start and end.
    unit: RangeUnit,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
        .unit = "Unit",
    };
};
