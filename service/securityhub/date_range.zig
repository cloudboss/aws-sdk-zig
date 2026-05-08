const DateRangeComparison = @import("date_range_comparison.zig").DateRangeComparison;
const DateRangeUnit = @import("date_range_unit.zig").DateRangeUnit;

/// A date range for the date filter.
pub const DateRange = struct {
    /// The condition to apply to a date range filter. If you specify `WITHIN`,
    /// Security Hub filters for dates within the specified date range. If you
    /// specify `OLDER_THAN`, Security Hub filters for dates before the specified
    /// date range. If you don't specify a value, the default is `WITHIN`.
    comparison: ?DateRangeComparison = null,

    /// A date range unit for the date filter.
    unit: ?DateRangeUnit = null,

    /// A date range value for the date filter.
    value: ?i32 = null,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .unit = "Unit",
        .value = "Value",
    };
};
