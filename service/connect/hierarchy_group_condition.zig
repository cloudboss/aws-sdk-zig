const HierarchyGroupMatchType = @import("hierarchy_group_match_type.zig").HierarchyGroupMatchType;

/// A leaf node condition which can be used to specify a hierarchy group
/// condition.
pub const HierarchyGroupCondition = struct {
    /// The type of hierarchy group match.
    hierarchy_group_match_type: ?HierarchyGroupMatchType,

    /// The value in the hierarchy group condition.
    value: ?[]const u8,

    pub const json_field_names = .{
        .hierarchy_group_match_type = "HierarchyGroupMatchType",
        .value = "Value",
    };
};
