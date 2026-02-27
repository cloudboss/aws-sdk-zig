/// An object representing the agent or data collector to be deleted along with
/// the optional configurations for error handling.
pub const DeleteAgent = struct {
    /// The ID of the agent or data collector to delete.
    agent_id: []const u8,

    /// Optional flag used to force delete an agent or data collector. It is needed
    /// to delete any agent in
    /// HEALTHY/UNHEALTHY/RUNNING status. Note that deleting an agent that is
    /// actively reporting health causes it
    /// to be re-registered with a different agent ID after data collector
    /// re-connects with Amazon Web Services.
    force: bool = false,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .force = "force",
    };
};
