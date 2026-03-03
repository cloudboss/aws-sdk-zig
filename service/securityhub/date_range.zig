const DateRangeUnit = @import("date_range_unit.zig").DateRangeUnit;

/// A date range for the date filter.
pub const DateRange = struct {
    /// A date range unit for the date filter.
    unit: ?DateRangeUnit = null,

    /// A date range value for the date filter.
    value: ?i32 = null,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
