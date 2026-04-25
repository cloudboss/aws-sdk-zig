const SubmissionStatus = @import("submission_status.zig").SubmissionStatus;

/// A single run entry returned by `ListRunsInBatch`.
pub const RunBatchListItem = struct {
    /// The unique ARN of the workflow run.
    run_arn: ?[]const u8 = null,

    /// The HealthOmics-generated identifier for the workflow run. Empty if
    /// submission failed.
    run_id: ?[]const u8 = null,

    /// The universally unique identifier (UUID) for the run.
    run_internal_uuid: ?[]const u8 = null,

    /// The customer-provided identifier for the run configuration. Use this to
    /// correlate results back to the input configuration provided in
    /// `inlineSettings` or `s3UriSettings`.
    run_setting_id: ?[]const u8 = null,

    /// A detailed message describing the submission failure.
    submission_failure_message: ?[]const u8 = null,

    /// The error category for a failed submission. See the run-level failure table
    /// in the HealthOmics User Guide for details on each value.
    submission_failure_reason: ?[]const u8 = null,

    /// The submission outcome for this run.
    submission_status: ?SubmissionStatus = null,

    pub const json_field_names = .{
        .run_arn = "runArn",
        .run_id = "runId",
        .run_internal_uuid = "runInternalUuid",
        .run_setting_id = "runSettingId",
        .submission_failure_message = "submissionFailureMessage",
        .submission_failure_reason = "submissionFailureReason",
        .submission_status = "submissionStatus",
    };
};
