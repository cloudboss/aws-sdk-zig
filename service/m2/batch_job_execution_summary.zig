const BatchJobIdentifier = @import("batch_job_identifier.zig").BatchJobIdentifier;
const BatchJobType = @import("batch_job_type.zig").BatchJobType;
const BatchJobExecutionStatus = @import("batch_job_execution_status.zig").BatchJobExecutionStatus;

/// A subset of the possible batch job attributes. Used in the batch job list.
pub const BatchJobExecutionSummary = struct {
    /// The unique identifier of the application that hosts this batch job.
    application_id: []const u8,

    /// The unique identifier of this batch job.
    batch_job_identifier: ?BatchJobIdentifier,

    /// The timestamp when this batch job execution ended.
    end_time: ?i64,

    /// The unique identifier of this execution of the batch job.
    execution_id: []const u8,

    /// The unique identifier of a particular batch job.
    job_id: ?[]const u8,

    /// The name of a particular batch job.
    job_name: ?[]const u8,

    /// The type of a particular batch job execution.
    job_type: ?BatchJobType,

    /// The batch job return code from either the Blu Age or Micro Focus runtime
    /// engines. For more
    /// information, see [Batch return
    /// codes](https://www.ibm.com/docs/en/was/8.5.5?topic=model-batch-return-codes)
    /// in the *IBM WebSphere Application Server*
    /// documentation.
    return_code: ?[]const u8,

    /// The timestamp when a particular batch job execution started.
    start_time: i64,

    /// The status of a particular batch job execution.
    status: BatchJobExecutionStatus,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .batch_job_identifier = "batchJobIdentifier",
        .end_time = "endTime",
        .execution_id = "executionId",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_type = "jobType",
        .return_code = "returnCode",
        .start_time = "startTime",
        .status = "status",
    };
};
