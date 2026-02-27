const FileBatchJobIdentifier = @import("file_batch_job_identifier.zig").FileBatchJobIdentifier;
const RestartBatchJobIdentifier = @import("restart_batch_job_identifier.zig").RestartBatchJobIdentifier;
const S3BatchJobIdentifier = @import("s3_batch_job_identifier.zig").S3BatchJobIdentifier;
const ScriptBatchJobIdentifier = @import("script_batch_job_identifier.zig").ScriptBatchJobIdentifier;

/// Identifies a specific batch job.
pub const BatchJobIdentifier = union(enum) {
    /// Specifies a file associated with a specific batch job.
    file_batch_job_identifier: ?FileBatchJobIdentifier,
    /// Specifies the required information for restart, including `executionId` and
    /// `JobStepRestartMarker`.
    restart_batch_job_identifier: ?RestartBatchJobIdentifier,
    /// Specifies an Amazon S3 location that identifies the batch jobs that you want
    /// to run. Use this identifier to run ad hoc batch jobs.
    s_3_batch_job_identifier: ?S3BatchJobIdentifier,
    /// A batch job identifier in which the batch job to run is identified by the
    /// script
    /// name.
    script_batch_job_identifier: ?ScriptBatchJobIdentifier,

    pub const json_field_names = .{
        .file_batch_job_identifier = "fileBatchJobIdentifier",
        .restart_batch_job_identifier = "restartBatchJobIdentifier",
        .s_3_batch_job_identifier = "s3BatchJobIdentifier",
        .script_batch_job_identifier = "scriptBatchJobIdentifier",
    };
};
