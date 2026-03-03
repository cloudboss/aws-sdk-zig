const SimpleAttributeAggregationFunction = @import("simple_attribute_aggregation_function.zig").SimpleAttributeAggregationFunction;

/// Aggregation for attributes.
pub const AttributeAggregationFunction = struct {
    /// The built-in aggregation functions for attributes.
    ///
    /// * `UNIQUE_VALUE`: Returns the unique value for a field, aggregated by the
    ///   dimension fields.
    simple_attribute_aggregation: ?SimpleAttributeAggregationFunction = null,

    /// Used by the `UNIQUE_VALUE` aggregation function. If there are multiple
    /// values for the field used by the aggregation, the value for this property
    /// will be returned instead. Defaults to '*'.
    value_for_multiple_values: ?[]const u8 = null,

    pub const json_field_names = .{
        .simple_attribute_aggregation = "SimpleAttributeAggregation",
        .value_for_multiple_values = "ValueForMultipleValues",
    };
};
