const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// A structure that represents a data aggregation.
pub const DataAggregation = struct {
    /// The level of time precision that is used to aggregate `DateTime` values.
    dataset_row_date_granularity: ?TopicTimeGranularity,

    /// The column name for the default date.
    default_date_column_name: ?[]const u8,

    pub const json_field_names = .{
        .dataset_row_date_granularity = "DatasetRowDateGranularity",
        .default_date_column_name = "DefaultDateColumnName",
    };
};
