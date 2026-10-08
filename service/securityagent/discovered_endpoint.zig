/// Represents an endpoint discovered during a pentest job.
pub const DiscoveredEndpoint = struct {
    /// The unique identifier of the agent space associated with the discovered
    /// endpoint.
    agent_space_id: []const u8,

    /// A description of the discovered endpoint.
    description: ?[]const u8 = null,

    /// The evidence that led to the discovery of the endpoint.
    evidence: ?[]const u8 = null,

    /// The HTTP operation associated with the discovered endpoint.
    operation: ?[]const u8 = null,

    /// The unique identifier of the pentest job that discovered the endpoint.
    pentest_job_id: []const u8,

    /// The unique identifier of the task that discovered the endpoint.
    task_id: []const u8,

    /// The URI of the discovered endpoint.
    uri: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .description = "description",
        .evidence = "evidence",
        .operation = "operation",
        .pentest_job_id = "pentestJobId",
        .task_id = "taskId",
        .uri = "uri",
    };
};
