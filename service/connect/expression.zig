const AttributeCondition = @import("attribute_condition.zig").AttributeCondition;

/// A tagged union to specify expression for a routing step.
pub const Expression = struct {
    /// List of routing expressions which will be AND-ed together.
    and_expression: ?[]const Expression,

    /// An object to specify the predefined attribute condition.
    attribute_condition: ?AttributeCondition,

    not_attribute_condition: ?AttributeCondition,

    /// List of routing expressions which will be OR-ed together.
    or_expression: ?[]const Expression,

    pub const json_field_names = .{
        .and_expression = "AndExpression",
        .attribute_condition = "AttributeCondition",
        .not_attribute_condition = "NotAttributeCondition",
        .or_expression = "OrExpression",
    };
};
