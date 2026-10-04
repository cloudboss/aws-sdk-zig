const ContactEvaluationAttributeAndCondition = @import("contact_evaluation_attribute_and_condition.zig").ContactEvaluationAttributeAndCondition;
const ContactEvaluationAttributeCondition = @import("contact_evaluation_attribute_condition.zig").ContactEvaluationAttributeCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// An object that can be used to specify tag conditions and attribute
/// conditions inside the
/// `SearchFilter` for contact evaluations. This accepts an `OR` or `AND`
/// (List of List) input where:
///
/// * The top level list specifies conditions that need to be applied with `OR`
///   operator.
///
/// * The inner list specifies conditions that need to be applied with `AND`
///   operator.
pub const ContactEvaluationAttributeFilter = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_condition: ?ContactEvaluationAttributeAndCondition = null,

    /// An attribute condition to apply.
    contact_evaluation_attribute_condition: ?ContactEvaluationAttributeCondition = null,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const ContactEvaluationAttributeAndCondition = null,

    /// A tag condition to apply.
    tag_condition: ?TagCondition = null,

    pub const json_field_names = .{
        .and_condition = "AndCondition",
        .contact_evaluation_attribute_condition = "ContactEvaluationAttributeCondition",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
