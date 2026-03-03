const CategoryFilter = @import("category_filter.zig").CategoryFilter;
const NestedFilter = @import("nested_filter.zig").NestedFilter;
const NumericEqualityFilter = @import("numeric_equality_filter.zig").NumericEqualityFilter;
const NumericRangeFilter = @import("numeric_range_filter.zig").NumericRangeFilter;
const RelativeDatesFilter = @import("relative_dates_filter.zig").RelativeDatesFilter;
const TimeEqualityFilter = @import("time_equality_filter.zig").TimeEqualityFilter;
const TimeRangeFilter = @import("time_range_filter.zig").TimeRangeFilter;
const TopBottomFilter = @import("top_bottom_filter.zig").TopBottomFilter;

/// With a `Filter`, you can remove portions of data from a particular visual or
/// view.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const Filter = struct {
    /// A `CategoryFilter` filters text values.
    ///
    /// For more information, see [Adding text
    /// filters](https://docs.aws.amazon.com/quicksight/latest/user/add-a-text-filter-data-prep.html) in the *Amazon Quick Suite User Guide*.
    category_filter: ?CategoryFilter = null,

    /// A `NestedFilter` filters data with a subset of data that is defined by the
    /// nested inner filter.
    nested_filter: ?NestedFilter = null,

    /// A `NumericEqualityFilter` filters numeric values that equal or do not equal
    /// a given numeric value.
    numeric_equality_filter: ?NumericEqualityFilter = null,

    /// A `NumericRangeFilter` filters numeric values that are either inside or
    /// outside a given numeric range.
    numeric_range_filter: ?NumericRangeFilter = null,

    /// A `RelativeDatesFilter` filters date values that are relative to a given
    /// date.
    relative_dates_filter: ?RelativeDatesFilter = null,

    /// A `TimeEqualityFilter` filters date-time values that equal or do not equal
    /// a given date/time value.
    time_equality_filter: ?TimeEqualityFilter = null,

    /// A `TimeRangeFilter` filters date-time values that are either inside or
    /// outside a given date/time range.
    time_range_filter: ?TimeRangeFilter = null,

    /// A `TopBottomFilter` filters data to the top or bottom values for a given
    /// column.
    top_bottom_filter: ?TopBottomFilter = null,

    pub const json_field_names = .{
        .category_filter = "CategoryFilter",
        .nested_filter = "NestedFilter",
        .numeric_equality_filter = "NumericEqualityFilter",
        .numeric_range_filter = "NumericRangeFilter",
        .relative_dates_filter = "RelativeDatesFilter",
        .time_equality_filter = "TimeEqualityFilter",
        .time_range_filter = "TimeRangeFilter",
        .top_bottom_filter = "TopBottomFilter",
    };
};
