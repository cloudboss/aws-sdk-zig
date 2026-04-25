const aws = @import("aws");

const CodeGenerationOutputFormatStatusDetails = @import("code_generation_output_format_status_details.zig").CodeGenerationOutputFormatStatusDetails;
const NetworkMigrationJobStatus = @import("network_migration_job_status.zig").NetworkMigrationJobStatus;

/// Details about a network migration code generation job.
pub const NetworkMigrationCodeGenerationJobDetails = struct {
    /// A map of output format types to their status details.
    code_generation_output_format_status_details_map: ?[]const aws.map.MapEntry(CodeGenerationOutputFormatStatusDetails) = null,

    /// The timestamp when the job was created.
    created_at: ?i64 = null,

    /// The timestamp when the job completed or failed.
    ended_at: ?i64 = null,

    /// The unique identifier of the code generation job.
    job_id: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The current status of the code generation job.
    status: ?NetworkMigrationJobStatus = null,

    /// Detailed status information about the job.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_generation_output_format_status_details_map = "codeGenerationOutputFormatStatusDetailsMap",
        .created_at = "createdAt",
        .ended_at = "endedAt",
        .job_id = "jobID",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .status = "status",
        .status_details = "statusDetails",
    };
};
