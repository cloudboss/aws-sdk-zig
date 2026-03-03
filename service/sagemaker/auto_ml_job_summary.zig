const AutoMLJobSecondaryStatus = @import("auto_ml_job_secondary_status.zig").AutoMLJobSecondaryStatus;
const AutoMLJobStatus = @import("auto_ml_job_status.zig").AutoMLJobStatus;
const AutoMLPartialFailureReason = @import("auto_ml_partial_failure_reason.zig").AutoMLPartialFailureReason;

/// Provides a summary about an AutoML job.
pub const AutoMLJobSummary = struct {
    /// The ARN of the AutoML job.
    auto_ml_job_arn: []const u8,

    /// The name of the AutoML job you are requesting.
    auto_ml_job_name: []const u8,

    /// The secondary status of the AutoML job.
    auto_ml_job_secondary_status: AutoMLJobSecondaryStatus,

    /// The status of the AutoML job.
    auto_ml_job_status: AutoMLJobStatus,

    /// When the AutoML job was created.
    creation_time: i64,

    /// The end time of an AutoML job.
    end_time: ?i64 = null,

    /// The failure reason of an AutoML job.
    failure_reason: ?[]const u8 = null,

    /// When the AutoML job was last modified.
    last_modified_time: i64,

    /// The list of reasons for partial failures within an AutoML job.
    partial_failure_reasons: ?[]const AutoMLPartialFailureReason = null,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_secondary_status = "AutoMLJobSecondaryStatus",
        .auto_ml_job_status = "AutoMLJobStatus",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .partial_failure_reasons = "PartialFailureReasons",
    };
};
