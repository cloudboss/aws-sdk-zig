const NetworkMigrationJobStatus = @import("network_migration_job_status.zig").NetworkMigrationJobStatus;

/// Details about a network migration deployer job.
pub const NetworkMigrationDeployerJobDetails = struct {
    /// The timestamp when the job was created.
    created_at: ?i64 = null,

    /// The timestamp when the job completed or failed.
    ended_at: ?i64 = null,

    /// The unique identifier of the deployer job.
    job_id: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The current status of the deployer job.
    status: ?NetworkMigrationJobStatus = null,

    /// Detailed status information about the job.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .ended_at = "endedAt",
        .job_id = "jobID",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .status = "status",
        .status_details = "statusDetails",
    };
};
