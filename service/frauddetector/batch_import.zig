const AsyncJobStatus = @import("async_job_status.zig").AsyncJobStatus;

/// The batch import job details.
pub const BatchImport = struct {
    /// The ARN of the batch import job.
    arn: ?[]const u8,

    /// Timestamp of when batch import job completed.
    completion_time: ?[]const u8,

    /// The name of the event type.
    event_type_name: ?[]const u8,

    /// The number of records that failed to import.
    failed_records_count: ?i32,

    /// The reason batch import job failed.
    failure_reason: ?[]const u8,

    /// The ARN of the IAM role to use for this job request.
    iam_role_arn: ?[]const u8,

    /// The Amazon S3 location of your data file for batch import.
    input_path: ?[]const u8,

    /// The ID of the batch import job.
    job_id: ?[]const u8,

    /// The Amazon S3 location of your output file.
    output_path: ?[]const u8,

    /// The number of records processed by batch import job.
    processed_records_count: ?i32,

    /// Timestamp of when the batch import job started.
    start_time: ?[]const u8,

    /// The status of the batch import job.
    status: ?AsyncJobStatus,

    /// The total number of records in the batch import job.
    total_records_count: ?i32,

    pub const json_field_names = .{
        .arn = "arn",
        .completion_time = "completionTime",
        .event_type_name = "eventTypeName",
        .failed_records_count = "failedRecordsCount",
        .failure_reason = "failureReason",
        .iam_role_arn = "iamRoleArn",
        .input_path = "inputPath",
        .job_id = "jobId",
        .output_path = "outputPath",
        .processed_records_count = "processedRecordsCount",
        .start_time = "startTime",
        .status = "status",
        .total_records_count = "totalRecordsCount",
    };
};
