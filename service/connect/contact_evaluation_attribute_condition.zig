const ContactEvaluationAttributeKey = @import("contact_evaluation_attribute_key.zig").ContactEvaluationAttributeKey;
const ContactEvaluationAttributeValue = @import("contact_evaluation_attribute_value.zig").ContactEvaluationAttributeValue;
const ContactEvaluationAttributeComparisonType = @import("contact_evaluation_attribute_comparison_type.zig").ContactEvaluationAttributeComparisonType;

/// An attribute condition for contact evaluation filtering.
pub const ContactEvaluationAttributeCondition = struct {
    /// The key of the attribute.
    attribute_key: ?ContactEvaluationAttributeKey = null,

    /// The value of the attribute.
    attribute_value: ?ContactEvaluationAttributeValue = null,

    /// The comparison type for the condition.
    comparison_type: ?ContactEvaluationAttributeComparisonType = null,

    pub const json_field_names = .{
        .attribute_key = "AttributeKey",
        .attribute_value = "AttributeValue",
        .comparison_type = "ComparisonType",
    };
};
