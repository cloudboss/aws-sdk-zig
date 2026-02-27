const HierarchyLevel = @import("hierarchy_level.zig").HierarchyLevel;

/// Contains information about a hierarchy structure.
pub const HierarchyStructure = struct {
    /// Information about level five.
    level_five: ?HierarchyLevel,

    /// Information about level four.
    level_four: ?HierarchyLevel,

    /// Information about level one.
    level_one: ?HierarchyLevel,

    /// Information about level three.
    level_three: ?HierarchyLevel,

    /// Information about level two.
    level_two: ?HierarchyLevel,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
