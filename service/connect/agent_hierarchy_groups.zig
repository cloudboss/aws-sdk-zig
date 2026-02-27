/// A structure that defines search criteria for contacts using agent hierarchy
/// group levels. For more information
/// about agent hierarchies, see [Set Up
/// Agent
/// Hierarchies](https://docs.aws.amazon.com/connect/latest/adminguide/agent-hierarchy.html) in the *Amazon Connect Administrator Guide*.
pub const AgentHierarchyGroups = struct {
    /// The identifiers for level 1 hierarchy groups.
    l1_ids: ?[]const []const u8,

    /// The identifiers for level 2 hierarchy groups.
    l2_ids: ?[]const []const u8,

    /// The identifiers for level 3 hierarchy groups.
    l3_ids: ?[]const []const u8,

    /// The identifiers for level 4 hierarchy groups.
    l4_ids: ?[]const []const u8,

    /// The identifiers for level 5 hierarchy groups.
    l5_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .l1_ids = "L1Ids",
        .l2_ids = "L2Ids",
        .l3_ids = "L3Ids",
        .l4_ids = "L4Ids",
        .l5_ids = "L5Ids",
    };
};
