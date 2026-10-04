const ContactEvaluationAttributeCondition = @import("contact_evaluation_attribute_condition.zig").ContactEvaluationAttributeCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// A list of conditions which would be applied together with an `AND`
/// condition.
pub const ContactEvaluationAttributeAndCondition = struct {
    /// A list of attribute conditions to apply.
    attribute_conditions: ?[]const ContactEvaluationAttributeCondition = null,

    /// A list of tag conditions to apply.
    tag_conditions: ?[]const TagCondition = null,

    pub const json_field_names = .{
        .attribute_conditions = "AttributeConditions",
        .tag_conditions = "TagConditions",
    };
};
