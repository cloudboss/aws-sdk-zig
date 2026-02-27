const TopicSingularFilterConstant = @import("topic_singular_filter_constant.zig").TopicSingularFilterConstant;
const TopicRelativeDateFilterFunction = @import("topic_relative_date_filter_function.zig").TopicRelativeDateFilterFunction;
const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// A structure that represents a relative date filter.
pub const TopicRelativeDateFilter = struct {
    /// The constant used in a
    /// relative date filter.
    constant: ?TopicSingularFilterConstant,

    /// The function to be used in a relative date filter to determine the range of
    /// dates to include in the results. Valid values for this structure are
    /// `BEFORE`, `AFTER`, and `BETWEEN`.
    relative_date_filter_function: ?TopicRelativeDateFilterFunction,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TopicTimeGranularity,

    pub const json_field_names = .{
        .constant = "Constant",
        .relative_date_filter_function = "RelativeDateFilterFunction",
        .time_granularity = "TimeGranularity",
    };
};
