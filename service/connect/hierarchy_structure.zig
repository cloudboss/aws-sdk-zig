const HierarchyLevel = @import("hierarchy_level.zig").HierarchyLevel;

/// Contains information about a hierarchy structure.
pub const HierarchyStructure = struct {
    /// Information about level five.
    level_five: ?HierarchyLevel = null,

    /// Information about level four.
    level_four: ?HierarchyLevel = null,

    /// Information about level one.
    level_one: ?HierarchyLevel = null,

    /// Information about level three.
    level_three: ?HierarchyLevel = null,

    /// Information about level two.
    level_two: ?HierarchyLevel = null,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
