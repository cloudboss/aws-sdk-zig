const AggregateFunctionName = @import("aggregate_function_name.zig").AggregateFunctionName;

/// Column in configured table that can be used in aggregate function in query.
pub const AggregateColumn = struct {
    /// Column names in configured table of aggregate columns.
    column_names: []const []const u8,

    /// Aggregation function that can be applied to aggregate column in query.
    function: AggregateFunctionName,

    pub const json_field_names = .{
        .column_names = "columnNames",
        .function = "function",
    };
};
