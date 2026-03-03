const TopicRangeFilterConstant = @import("topic_range_filter_constant.zig").TopicRangeFilterConstant;

/// A filter used to restrict data based on a range of dates or times.
pub const TopicDateRangeFilter = struct {
    /// The constant used in a date range filter.
    constant: ?TopicRangeFilterConstant = null,

    /// A Boolean value that indicates whether the date range filter should include
    /// the boundary values. If
    /// set to true, the filter includes the start and end dates. If set to false,
    /// the filter
    /// excludes them.
    inclusive: bool = false,

    pub const json_field_names = .{
        .constant = "Constant",
        .inclusive = "Inclusive",
    };
};
