const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// Represents a request to perform a `PutItem` operation.
pub const Put = struct {
    /// A condition that must be satisfied in order for a conditional update to
    /// succeed.
    condition_expression: ?[]const u8,

    /// One or more substitution tokens for attribute names in an expression.
    expression_attribute_names: ?[]const u8,

    /// One or more values that can be substituted in an expression.
    expression_attribute_values: ?[]const u8,

    /// A map of attribute name to attribute values, representing the primary key of
    /// the item
    /// to be written by `PutItem`. All of the table's primary key attributes must
    /// be
    /// specified, and their data types must match those of the table's key schema.
    /// If any
    /// attributes are present in the item that are part of an index key schema for
    /// the table,
    /// their types must match the index key schema.
    item: []const u8,

    /// Use `ReturnValuesOnConditionCheckFailure` to get the item attributes if the
    /// `Put` condition fails. For
    /// `ReturnValuesOnConditionCheckFailure`, the valid values are: NONE and
    /// ALL_OLD.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure,

    /// Name of the table in which to write the item. You can also provide the
    /// Amazon Resource Name (ARN) of
    /// the table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .condition_expression = "ConditionExpression",
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .item = "Item",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .table_name = "TableName",
    };
};
