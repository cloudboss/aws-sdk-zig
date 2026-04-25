const EntityType = @import("entity_type.zig").EntityType;
const LibraryIngestionJobStatus = @import("library_ingestion_job_status.zig").LibraryIngestionJobStatus;
const LibraryIngestionJobOperationType = @import("library_ingestion_job_operation_type.zig").LibraryIngestionJobOperationType;

/// Summary of a DataAutomationLibraryIngestionJob
pub const DataAutomationLibraryIngestionJobSummary = struct {
    completion_time: ?i64 = null,

    creation_time: i64,

    entity_type: EntityType,

    job_arn: []const u8,

    job_status: LibraryIngestionJobStatus,

    operation_type: LibraryIngestionJobOperationType,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .entity_type = "entityType",
        .job_arn = "jobArn",
        .job_status = "jobStatus",
        .operation_type = "operationType",
    };
};
