const FilterExpressionType = @import("filter_expression_type.zig").FilterExpressionType;

/// A filter expression in Amazon DataZone.
pub const FilterExpression = struct {
    /// The search filter expression.
    expression: []const u8,

    /// The search filter explresison type.
    type: FilterExpressionType,

    pub const json_field_names = .{
        .expression = "expression",
        .type = "type",
    };
};
