const ContactFilter = @import("contact_filter.zig").ContactFilter;

/// A filter for the user data.
pub const UserDataFilters = struct {
    /// A list of up to 100 agent IDs or ARNs.
    agents: ?[]const []const u8,

    /// A filter for the user data based on the contact information that is
    /// associated to the user. It contains a list
    /// of contact states.
    contact_filter: ?ContactFilter,

    /// A list of up to 100 queues or ARNs.
    queues: ?[]const []const u8,

    /// A list of up to 100 routing profile IDs or ARNs.
    routing_profiles: ?[]const []const u8,

    /// A UserHierarchyGroup ID or ARN.
    user_hierarchy_groups: ?[]const []const u8,

    pub const json_field_names = .{
        .agents = "Agents",
        .contact_filter = "ContactFilter",
        .queues = "Queues",
        .routing_profiles = "RoutingProfiles",
        .user_hierarchy_groups = "UserHierarchyGroups",
    };
};
