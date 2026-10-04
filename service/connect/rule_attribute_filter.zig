const RuleAttributeAndCondition = @import("rule_attribute_and_condition.zig").RuleAttributeAndCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// An object that can be used to specify tag conditions inside the
/// `SearchFilter`. This accepts an
/// `OR` of `AND` (List of List) input where:
///
/// * The top level list specifies conditions that need to be applied with `OR`
///   operator.
///
/// * The inner list specifies conditions that need to be applied with `AND`
///   operator.
pub const RuleAttributeFilter = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_condition: ?RuleAttributeAndCondition = null,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const RuleAttributeAndCondition = null,

    tag_condition: ?TagCondition = null,

    pub const json_field_names = .{
        .and_condition = "AndCondition",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
