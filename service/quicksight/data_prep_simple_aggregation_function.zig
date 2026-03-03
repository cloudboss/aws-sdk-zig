const DataPrepSimpleAggregationFunctionType = @import("data_prep_simple_aggregation_function_type.zig").DataPrepSimpleAggregationFunctionType;

/// A simple aggregation function that performs standard statistical operations
/// on a column.
pub const DataPrepSimpleAggregationFunction = struct {
    /// The type of aggregation function to perform, such as `COUNT`, `SUM`,
    /// `AVERAGE`,
    /// `MIN`, `MAX`, `MEDIAN`, `VARIANCE`, or `STANDARD_DEVIATION`.
    function_type: DataPrepSimpleAggregationFunctionType,

    /// The name of the column on which to perform the aggregation function.
    input_column_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_type = "FunctionType",
        .input_column_name = "InputColumnName",
    };
};
