const HierarchyGroupSummary = @import("hierarchy_group_summary.zig").HierarchyGroupSummary;

/// Contains information about the levels of a hierarchy group.
pub const HierarchyPath = struct {
    /// Information about level five.
    level_five: ?HierarchyGroupSummary,

    /// Information about level four.
    level_four: ?HierarchyGroupSummary,

    /// Information about level one.
    level_one: ?HierarchyGroupSummary,

    /// Information about level three.
    level_three: ?HierarchyGroupSummary,

    /// Information about level two.
    level_two: ?HierarchyGroupSummary,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
