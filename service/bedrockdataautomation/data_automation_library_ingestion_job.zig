const EntityType = @import("entity_type.zig").EntityType;
const LibraryIngestionJobStatus = @import("library_ingestion_job_status.zig").LibraryIngestionJobStatus;
const LibraryIngestionJobOperationType = @import("library_ingestion_job_operation_type.zig").LibraryIngestionJobOperationType;
const OutputConfiguration = @import("output_configuration.zig").OutputConfiguration;

/// Contains the information of a DataAutomationLibraryIngestionJob
pub const DataAutomationLibraryIngestionJob = struct {
    /// Timestamp when the DataAutomationLibraryIngestionJob was completed
    completion_time: ?i64 = null,

    /// Timestamp when the DataAutomationLibraryIngestionJob was created
    creation_time: i64,

    /// The entity type associated with DataAutomationLibraryIngestionJob
    entity_type: EntityType,

    /// Error message
    error_message: ?[]const u8 = null,

    /// Error type
    error_type: ?[]const u8 = null,

    /// ARN of the DataAutomationLibraryIngestionJob
    job_arn: []const u8,

    /// The status of the DataAutomationLibraryIngestionJob
    job_status: LibraryIngestionJobStatus,

    /// The operation associated with DataAutomationLibraryIngestionJob
    operation_type: LibraryIngestionJobOperationType,

    /// Output configuration of DataAutomationLibraryIngestionJob
    output_configuration: OutputConfiguration,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .entity_type = "entityType",
        .error_message = "errorMessage",
        .error_type = "errorType",
        .job_arn = "jobArn",
        .job_status = "jobStatus",
        .operation_type = "operationType",
        .output_configuration = "outputConfiguration",
    };
};
