const NumericalAggregationFunction = @import("numerical_aggregation_function.zig").NumericalAggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;

/// The dynamic configuration of the reference line data configuration.
pub const ReferenceLineDynamicDataConfiguration = struct {
    /// The calculation that is used in the dynamic data.
    calculation: NumericalAggregationFunction,

    /// The column that the dynamic data targets.
    column: ColumnIdentifier,

    /// The aggregation function that is used in the dynamic data.
    measure_aggregation_function: ?AggregationFunction = null,

    pub const json_field_names = .{
        .calculation = "Calculation",
        .column = "Column",
        .measure_aggregation_function = "MeasureAggregationFunction",
    };
};
