const HierarchyGroupSummaryReference = @import("hierarchy_group_summary_reference.zig").HierarchyGroupSummaryReference;

/// Information about the levels in the hierarchy group.
pub const HierarchyPathReference = struct {
    /// Information about level five.
    level_five: ?HierarchyGroupSummaryReference = null,

    /// Information about level four.
    level_four: ?HierarchyGroupSummaryReference = null,

    /// Information about level one.
    level_one: ?HierarchyGroupSummaryReference = null,

    /// Information about level three.
    level_three: ?HierarchyGroupSummaryReference = null,

    /// Information about level two.
    level_two: ?HierarchyGroupSummaryReference = null,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
