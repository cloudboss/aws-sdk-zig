const HierarchyGroupSummary = @import("hierarchy_group_summary.zig").HierarchyGroupSummary;

/// Contains information about the levels of a hierarchy group.
pub const HierarchyPath = struct {
    /// Information about level five.
    level_five: ?HierarchyGroupSummary = null,

    /// Information about level four.
    level_four: ?HierarchyGroupSummary = null,

    /// Information about level one.
    level_one: ?HierarchyGroupSummary = null,

    /// Information about level three.
    level_three: ?HierarchyGroupSummary = null,

    /// Information about level two.
    level_two: ?HierarchyGroupSummary = null,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
