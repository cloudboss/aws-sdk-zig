const TagCondition = @import("tag_condition.zig").TagCondition;

/// An object that can be used to specify Tag conditions inside the
/// `SearchFilter`. This accepts an
/// `OR` of `AND` (List of List) input where:
///
/// * Top level list specifies conditions that need to be applied with `OR`
///   operator
///
/// * Inner list specifies conditions that need to be applied with `AND`
///   operator.
pub const ControlPlaneTagFilter = struct {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const TagCondition,

    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const []const TagCondition,

    /// A leaf node condition which can be used to specify a tag condition.
    tag_condition: ?TagCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .tag_condition = "TagCondition",
    };
};
