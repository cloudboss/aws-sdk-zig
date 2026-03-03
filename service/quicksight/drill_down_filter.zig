const CategoryDrillDownFilter = @import("category_drill_down_filter.zig").CategoryDrillDownFilter;
const NumericEqualityDrillDownFilter = @import("numeric_equality_drill_down_filter.zig").NumericEqualityDrillDownFilter;
const TimeRangeDrillDownFilter = @import("time_range_drill_down_filter.zig").TimeRangeDrillDownFilter;

/// The drill down filter for the column hierarchies.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const DrillDownFilter = struct {
    /// The category type drill down filter. This filter is used for string type
    /// columns.
    category_filter: ?CategoryDrillDownFilter = null,

    /// The numeric equality type drill down filter. This filter is used for number
    /// type columns.
    numeric_equality_filter: ?NumericEqualityDrillDownFilter = null,

    /// The time range drill down filter. This filter is used for date time columns.
    time_range_filter: ?TimeRangeDrillDownFilter = null,

    pub const json_field_names = .{
        .category_filter = "CategoryFilter",
        .numeric_equality_filter = "NumericEqualityFilter",
        .time_range_filter = "TimeRangeFilter",
    };
};
