const HierarchyLevelUpdate = @import("hierarchy_level_update.zig").HierarchyLevelUpdate;

/// Contains information about the level hierarchy to update.
pub const HierarchyStructureUpdate = struct {
    /// The update for level five.
    level_five: ?HierarchyLevelUpdate,

    /// The update for level four.
    level_four: ?HierarchyLevelUpdate,

    /// The
    /// update
    /// for level one.
    level_one: ?HierarchyLevelUpdate,

    /// The update for level three.
    level_three: ?HierarchyLevelUpdate,

    /// The update for level two.
    level_two: ?HierarchyLevelUpdate,

    pub const json_field_names = .{
        .level_five = "LevelFive",
        .level_four = "LevelFour",
        .level_one = "LevelOne",
        .level_three = "LevelThree",
        .level_two = "LevelTwo",
    };
};
