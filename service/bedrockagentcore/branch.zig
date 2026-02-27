/// Contains information about a branch in an AgentCore Memory resource.
/// Branches allow for organizing events into different conversation threads or
/// paths.
pub const Branch = struct {
    /// The name of the branch.
    name: []const u8,

    /// The identifier of the root event for this branch.
    root_event_id: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .root_event_id = "rootEventId",
    };
};
