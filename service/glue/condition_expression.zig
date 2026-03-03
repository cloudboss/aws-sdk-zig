/// Condition expression defined in the Glue Studio data preparation recipe
/// node.
pub const ConditionExpression = struct {
    /// The condition of the condition expression.
    condition: []const u8,

    /// The target column of the condition expressions.
    target_column: []const u8,

    /// The value of the condition expression.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .target_column = "TargetColumn",
        .value = "Value",
    };
};
