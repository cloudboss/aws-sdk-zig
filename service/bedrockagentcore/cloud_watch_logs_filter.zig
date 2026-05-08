const CloudWatchLogsFilterOperator = @import("cloud_watch_logs_filter_operator.zig").CloudWatchLogsFilterOperator;
const FilterValue = @import("filter_value.zig").FilterValue;

/// A filter for narrowing down agent traces from CloudWatch Logs based on
/// key-value comparisons.
pub const CloudWatchLogsFilter = struct {
    /// The key or field name to filter on within the agent trace data.
    key: []const u8,

    /// The comparison operator to use for filtering.
    operator: CloudWatchLogsFilterOperator,

    /// The value to compare against using the specified operator.
    value: FilterValue,

    pub const json_field_names = .{
        .key = "key",
        .operator = "operator",
        .value = "value",
    };
};
