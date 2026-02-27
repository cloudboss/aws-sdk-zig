const RuleNumberEmailAttribute = @import("rule_number_email_attribute.zig").RuleNumberEmailAttribute;

/// The number to evaluate in a numeric condition expression.
pub const RuleNumberToEvaluate = union(enum) {
    /// An email attribute that is used as the number to evaluate.
    attribute: ?RuleNumberEmailAttribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
