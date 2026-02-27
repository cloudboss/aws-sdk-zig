/// Information about agents that were instructed to start collecting data.
/// Information includes the agent ID, a description of the operation, and
/// whether the
/// agent configuration was updated.
pub const AgentConfigurationStatus = struct {
    /// The agent ID.
    agent_id: ?[]const u8,

    /// A description of the operation performed.
    description: ?[]const u8,

    /// Information about the status of the `StartDataCollection` and
    /// `StopDataCollection` operations. The system has recorded the data collection
    /// operation. The agent receives this command the next time it polls for a new
    /// command.
    operation_succeeded: bool = false,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .description = "description",
        .operation_succeeded = "operationSucceeded",
    };
};
