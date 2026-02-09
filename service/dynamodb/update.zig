const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// Represents a request to perform an `UpdateItem` operation.
pub const Update = struct {
    /// A condition that must be satisfied in order for a conditional update to
    /// succeed.
    condition_expression: ?[]const u8,

    /// One or more substitution tokens for attribute names in an expression.
    expression_attribute_names: ?[]const u8,

    /// One or more values that can be substituted in an expression.
    expression_attribute_values: ?[]const u8,

    /// The primary key of the item to be updated. Each element consists of an
    /// attribute name
    /// and a value for that attribute.
    key: []const u8,

    /// Use `ReturnValuesOnConditionCheckFailure` to get the item attributes if the
    /// `Update` condition fails. For
    /// `ReturnValuesOnConditionCheckFailure`, the valid values are: NONE and
    /// ALL_OLD.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure,

    /// Name of the table for the `UpdateItem` request. You can also provide the
    /// Amazon Resource Name (ARN) of the table in this parameter.
    table_name: []const u8,

    /// An expression that defines one or more attributes to be updated, the action
    /// to be
    /// performed on them, and new value(s) for them.
    update_expression: []const u8,
};
