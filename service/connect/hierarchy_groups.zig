const AgentHierarchyGroup = @import("agent_hierarchy_group.zig").AgentHierarchyGroup;

/// Information about the agent hierarchy. Hierarchies can be configured with up
/// to five levels.
pub const HierarchyGroups = struct {
    /// The group at level one of the agent hierarchy.
    level_1: ?AgentHierarchyGroup,

    /// The group at level two of the agent hierarchy.
    level_2: ?AgentHierarchyGroup,

    /// The group at level three of the agent hierarchy.
    level_3: ?AgentHierarchyGroup,

    /// The group at level four of the agent hierarchy.
    level_4: ?AgentHierarchyGroup,

    /// The group at level five of the agent hierarchy.
    level_5: ?AgentHierarchyGroup,

    pub const json_field_names = .{
        .level_1 = "Level1",
        .level_2 = "Level2",
        .level_3 = "Level3",
        .level_4 = "Level4",
        .level_5 = "Level5",
    };
};
