const AsyncJobStatus = @import("async_job_status.zig").AsyncJobStatus;

/// The batch prediction details.
pub const BatchPrediction = struct {
    /// The ARN of batch prediction job.
    arn: ?[]const u8,

    /// Timestamp of when the batch prediction job completed.
    completion_time: ?[]const u8,

    /// The name of the detector.
    detector_name: ?[]const u8,

    /// The detector version.
    detector_version: ?[]const u8,

    /// The name of the event type.
    event_type_name: ?[]const u8,

    /// The reason a batch prediction job failed.
    failure_reason: ?[]const u8,

    /// The ARN of the IAM role to use for this job request.
    iam_role_arn: ?[]const u8,

    /// The Amazon S3 location of your training file.
    input_path: ?[]const u8,

    /// The job ID for the batch prediction.
    job_id: ?[]const u8,

    /// Timestamp of most recent heartbeat indicating the batch prediction job was
    /// making progress.
    last_heartbeat_time: ?[]const u8,

    /// The Amazon S3 location of your output file.
    output_path: ?[]const u8,

    /// The number of records processed by the batch prediction job.
    processed_records_count: ?i32,

    /// Timestamp of when the batch prediction job started.
    start_time: ?[]const u8,

    /// The batch prediction status.
    status: ?AsyncJobStatus,

    /// The total number of records in the batch prediction job.
    total_records_count: ?i32,

    pub const json_field_names = .{
        .arn = "arn",
        .completion_time = "completionTime",
        .detector_name = "detectorName",
        .detector_version = "detectorVersion",
        .event_type_name = "eventTypeName",
        .failure_reason = "failureReason",
        .iam_role_arn = "iamRoleArn",
        .input_path = "inputPath",
        .job_id = "jobId",
        .last_heartbeat_time = "lastHeartbeatTime",
        .output_path = "outputPath",
        .processed_records_count = "processedRecordsCount",
        .start_time = "startTime",
        .status = "status",
        .total_records_count = "totalRecordsCount",
    };
};
