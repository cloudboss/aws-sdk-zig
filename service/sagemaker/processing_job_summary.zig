const ProcessingJobStatus = @import("processing_job_status.zig").ProcessingJobStatus;

/// Summary of information about a processing job.
pub const ProcessingJobSummary = struct {
    /// The time at which the processing job was created.
    creation_time: i64,

    /// An optional string, up to one KB in size, that contains metadata from the
    /// processing container when the processing job exits.
    exit_message: ?[]const u8,

    /// A string, up to one KB in size, that contains the reason a processing job
    /// failed, if it failed.
    failure_reason: ?[]const u8,

    /// A timestamp that indicates the last time the processing job was modified.
    last_modified_time: ?i64,

    /// The time at which the processing job completed.
    processing_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the processing job..
    processing_job_arn: []const u8,

    /// The name of the processing job.
    processing_job_name: []const u8,

    /// The status of the processing job.
    processing_job_status: ProcessingJobStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .exit_message = "ExitMessage",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .processing_end_time = "ProcessingEndTime",
        .processing_job_arn = "ProcessingJobArn",
        .processing_job_name = "ProcessingJobName",
        .processing_job_status = "ProcessingJobStatus",
    };
};
