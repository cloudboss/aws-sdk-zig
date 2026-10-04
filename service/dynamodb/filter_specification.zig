const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Contains the filter criteria used to limit which items are included in an
/// export.
/// If you don't include this parameter, all items and attributes are exported.
pub const FilterSpecification = struct {
    /// One or more substitution tokens for attribute names in an expression. For
    /// more
    /// information, see [Expression Attribute
    /// Names](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.ExpressionAttributeNames.html) in the Amazon DynamoDB Developer Guide.
    expression_attribute_names: ?[]const aws.map.StringMapEntry = null,

    /// One or more values that can be substituted in an expression. For more
    /// information,
    /// see [Expression Attribute
    /// Values](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.ExpressionAttributeValues.html) in the Amazon DynamoDB Developer Guide.
    expression_attribute_values: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// A condition that filters which items are included in the export. This
    /// parameter
    /// uses the same syntax as `FilterExpression` in `Query` and
    /// `Scan`. If you don't provide `KeyConditionExpression`, this
    /// expression can also reference key attributes. If you don't specify this
    /// parameter,
    /// all items are included in the export.
    filter_expression: ?[]const u8 = null,

    /// A condition expression that filters items by key values. The expression must
    /// test
    /// equality on a single partition key value and can optionally compare a sort
    /// key value.
    /// This parameter uses the same syntax as `KeyConditionExpression` in
    /// `Query`. When you provide this parameter, `FilterExpression`
    /// can only reference non-key attributes. If you don't specify this parameter,
    /// all items
    /// are eligible for export.
    key_condition_expression: ?[]const u8 = null,

    /// The attributes you want to retrieve for items included in the export.
    /// Separate
    /// attribute names in the expression with commas. If you don't specify this
    /// parameter,
    /// all attributes are returned.
    projection_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .expression_attribute_names = "ExpressionAttributeNames",
        .expression_attribute_values = "ExpressionAttributeValues",
        .filter_expression = "FilterExpression",
        .key_condition_expression = "KeyConditionExpression",
        .projection_expression = "ProjectionExpression",
    };
};
