const Analysis = @import("analysis.zig").Analysis;
const RuleBooleanEmailAttribute = @import("rule_boolean_email_attribute.zig").RuleBooleanEmailAttribute;
const RuleIsInAddressList = @import("rule_is_in_address_list.zig").RuleIsInAddressList;

/// The union type representing the allowed types of operands for a boolean
/// condition.
pub const RuleBooleanToEvaluate = union(enum) {
    /// The Add On ARN and its returned value to evaluate in a boolean condition
    /// expression.
    analysis: ?Analysis,
    /// The boolean type representing the allowed attribute types for an email.
    attribute: ?RuleBooleanEmailAttribute,
    /// The structure representing the address lists and address list attribute that
    /// will be used in evaluation of boolean expression.
    is_in_address_list: ?RuleIsInAddressList,

    pub const json_field_names = .{
        .analysis = "Analysis",
        .attribute = "Attribute",
        .is_in_address_list = "IsInAddressList",
    };
};
