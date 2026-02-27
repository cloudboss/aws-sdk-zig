const DimensionValueOperator = @import("dimension_value_operator.zig").DimensionValueOperator;

/// The dimension of a metric.
pub const MetricDimension = struct {
    /// A unique identifier for the dimension.
    dimension_name: []const u8,

    /// Defines how the `dimensionValues` of a dimension are interpreted. For
    /// example, for dimension type TOPIC_FILTER, the `IN` operator, a message will
    /// be counted only if its topic matches one of the topic filters. With `NOT_IN`
    /// operator, a message will be counted only if it doesn't match any of the
    /// topic filters. The operator is optional: if it's not provided (is `null`),
    /// it will be interpreted as `IN`.
    operator: ?DimensionValueOperator,

    pub const json_field_names = .{
        .dimension_name = "dimensionName",
        .operator = "operator",
    };
};
