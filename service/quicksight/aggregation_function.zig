const AttributeAggregationFunction = @import("attribute_aggregation_function.zig").AttributeAggregationFunction;
const CategoricalAggregationFunction = @import("categorical_aggregation_function.zig").CategoricalAggregationFunction;
const DateAggregationFunction = @import("date_aggregation_function.zig").DateAggregationFunction;
const NumericalAggregationFunction = @import("numerical_aggregation_function.zig").NumericalAggregationFunction;

/// An aggregation function aggregates values from a dimension or measure.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const AggregationFunction = struct {
    /// Aggregation for attributes.
    attribute_aggregation_function: ?AttributeAggregationFunction = null,

    /// Aggregation for categorical values.
    ///
    /// * `COUNT`: Aggregate by the total number of values, including duplicates.
    ///
    /// * `DISTINCT_COUNT`: Aggregate by the total number of distinct values.
    categorical_aggregation_function: ?CategoricalAggregationFunction = null,

    /// Aggregation for date values.
    ///
    /// * `COUNT`: Aggregate by the total number of values, including duplicates.
    ///
    /// * `DISTINCT_COUNT`: Aggregate by the total number of distinct values.
    ///
    /// * `MIN`: Select the smallest date value.
    ///
    /// * `MAX`: Select the largest date value.
    date_aggregation_function: ?DateAggregationFunction = null,

    /// Aggregation for numerical values.
    numerical_aggregation_function: ?NumericalAggregationFunction = null,

    pub const json_field_names = .{
        .attribute_aggregation_function = "AttributeAggregationFunction",
        .categorical_aggregation_function = "CategoricalAggregationFunction",
        .date_aggregation_function = "DateAggregationFunction",
        .numerical_aggregation_function = "NumericalAggregationFunction",
    };
};
