const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// Represents a request to perform a check that an item exists or to check the
/// condition
/// of specific attributes of the item.
pub const ConditionCheck = struct {
    /// A condition that must be satisfied in order for a conditional update to
    /// succeed. For
    /// more information, see [Condition
    /// expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.ConditionExpressions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    condition_expression: []const u8,

    /// One or more substitution tokens for attribute names in an expression. For
    /// more
    /// information, see [Expression attribute
    /// names](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.ExpressionAttributeNames.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_names: ?[]const aws.map.StringMapEntry = null,

    /// One or more values that can be substituted in an expression. For more
    /// information, see
    /// [Condition
    /// expressions](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.ConditionExpressions.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    expression_attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The primary key of the item to be checked. Each element consists of an
    /// attribute name
    /// and a value for that attribute.
    key: []const aws.map.MapEntry(AttributeValue),

    /// Use `ReturnValuesOnConditionCheckFailure` to get the item attributes if the
    /// `ConditionCheck` condition fails. For
    /// `ReturnValuesOnConditionCheckFailure`, the valid values are: NONE and
    /// ALL_OLD.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure = null,

    /// Name of the table for the check item request. You can also provide the
    /// Amazon Resource Name (ARN) of
    /// the table in this parameter.
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
