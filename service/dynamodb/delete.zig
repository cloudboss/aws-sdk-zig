const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// Represents a request to perform a `DeleteItem` operation.
pub const Delete = struct {
    /// A condition that must be satisfied in order for a conditional delete to
    /// succeed.
    condition_expression: ?[]const u8,

    /// One or more substitution tokens for attribute names in an expression.
    expression_attribute_names: ?[]const u8,

    /// One or more values that can be substituted in an expression.
    expression_attribute_values: ?[]const u8,

    /// The primary key of the item to be deleted. Each element consists of an
    /// attribute name
    /// and a value for that attribute.
    key: []const u8,

    /// Use `ReturnValuesOnConditionCheckFailure` to get the item attributes if the
    /// `Delete` condition fails. For
    /// `ReturnValuesOnConditionCheckFailure`, the valid values are: NONE and
    /// ALL_OLD.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure,

    /// Name of the table in which the item to be deleted resides. You can also
    /// provide the
    /// Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .condition_expression = "ConditionExpression",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .key = "Key",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .table_name = "TableName",
    };
};
