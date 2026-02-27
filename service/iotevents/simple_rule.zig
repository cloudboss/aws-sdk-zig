const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// A rule that compares an input property value to a threshold value with a
/// comparison operator.
pub const SimpleRule = struct {
    /// The comparison operator.
    comparison_operator: ComparisonOperator,

    /// The value on the left side of the comparison operator. You can specify an
    /// AWS IoT Events input
    /// attribute as an input property.
    input_property: []const u8,

    /// The value on the right side of the comparison operator. You can enter a
    /// number or specify
    /// an AWS IoT Events input attribute.
    threshold: []const u8,

    pub const json_field_names = .{
        .comparison_operator = "comparisonOperator",
        .input_property = "inputProperty",
        .threshold = "threshold",
    };
};
