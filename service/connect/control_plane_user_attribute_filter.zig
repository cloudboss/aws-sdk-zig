const AttributeAndCondition = @import("attribute_and_condition.zig").AttributeAndCondition;
const HierarchyGroupCondition = @import("hierarchy_group_condition.zig").HierarchyGroupCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// An object that can be used to specify Tag conditions or Hierarchy Group
/// conditions inside the
/// `SearchFilter`.
///
/// This accepts an `OR` of `AND` (List of List) input where:
///
/// * The top level list specifies conditions that need to be applied with `OR`
///   operator
///
/// * The inner list specifies conditions that need to be applied with `AND`
///   operator.
///
/// Only one field can be populated. Maximum number of allowed Tag conditions is
/// 25. Maximum number of allowed
/// Hierarchy Group conditions is 20.
pub const ControlPlaneUserAttributeFilter = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_condition: ?AttributeAndCondition = null,

    hierarchy_group_condition: ?HierarchyGroupCondition = null,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const AttributeAndCondition = null,

    tag_condition: ?TagCondition = null,

    pub const json_field_names = .{
        .and_condition = "AndCondition",
        .hierarchy_group_condition = "HierarchyGroupCondition",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
