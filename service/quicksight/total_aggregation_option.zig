const TotalAggregationFunction = @import("total_aggregation_function.zig").TotalAggregationFunction;

/// The total aggregation settings map of a field id.
pub const TotalAggregationOption = struct {
    /// The field id that's associated with the total aggregation option.
    field_id: []const u8,

    /// The total aggregation function that you want to set for a specified field
    /// id.
    total_aggregation_function: TotalAggregationFunction,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .total_aggregation_function = "TotalAggregationFunction",
    };
};
