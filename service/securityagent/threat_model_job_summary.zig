const JobStatus = @import("job_status.zig").JobStatus;

/// Contains summary information about a threat model job.
pub const ThreatModelJobSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The date and time the threat model job was created, in UTC format.
    created_at: ?i64 = null,

    /// The current status of the threat model job.
    status: ?JobStatus = null,

    /// The unique identifier of the threat model associated with the job.
    threat_model_id: []const u8,

    /// The unique identifier of the threat model job.
    threat_model_job_id: []const u8,

    /// The title of the threat model job.
    title: ?[]const u8 = null,

    /// The date and time the threat model job was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .status = "status",
        .threat_model_id = "threatModelId",
        .threat_model_job_id = "threatModelJobId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
