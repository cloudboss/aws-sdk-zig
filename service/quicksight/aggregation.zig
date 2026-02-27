const DataPrepAggregationFunction = @import("data_prep_aggregation_function.zig").DataPrepAggregationFunction;

/// Defines an aggregation function to be applied to grouped data, creating a
/// new column with
/// the calculated result.
pub const Aggregation = struct {
    /// The aggregation function to apply, such as `SUM`, `COUNT`, `AVERAGE`,
    /// `MIN`, `MAX`
    aggregation_function: DataPrepAggregationFunction,

    /// A unique identifier for the new column that will contain the aggregated
    /// values.
    new_column_id: []const u8,

    /// The name for the new column that will contain the aggregated values.
    new_column_name: []const u8,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .new_column_id = "NewColumnId",
        .new_column_name = "NewColumnName",
    };
};
