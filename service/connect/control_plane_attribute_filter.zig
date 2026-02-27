const CommonAttributeAndCondition = @import("common_attribute_and_condition.zig").CommonAttributeAndCondition;
const TagCondition = @import("tag_condition.zig").TagCondition;

/// An object that can be used to specify Tag conditions inside the
/// `SearchFilter`. This accepts an
/// `OR` or `AND` (List of List) input where:
///
/// * The top level list specifies conditions that need to be applied with `OR`
///   operator.
///
/// * The inner list specifies conditions that need to be applied with `AND`
///   operator.
pub const ControlPlaneAttributeFilter = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_condition: ?CommonAttributeAndCondition,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const CommonAttributeAndCondition,

    tag_condition: ?TagCondition,

    pub const json_field_names = .{
        .and_condition = "AndCondition",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
