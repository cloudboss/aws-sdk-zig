/// A summary of the submissions in a batch.
pub const SubmissionSummary = struct {
    /// The number of failed cancel submissions.
    failed_cancel_submission_count: ?i32 = null,

    /// The number of failed delete submissions.
    failed_delete_submission_count: ?i32 = null,

    /// The number of failed start submissions.
    failed_start_submission_count: ?i32 = null,

    /// The number of pending start submissions.
    pending_start_submission_count: ?i32 = null,

    /// The number of successful cancel submissions.
    successful_cancel_submission_count: ?i32 = null,

    /// The number of successful delete submissions.
    successful_delete_submission_count: ?i32 = null,

    /// The number of successful start submissions.
    successful_start_submission_count: ?i32 = null,

    pub const json_field_names = .{
        .failed_cancel_submission_count = "failedCancelSubmissionCount",
        .failed_delete_submission_count = "failedDeleteSubmissionCount",
        .failed_start_submission_count = "failedStartSubmissionCount",
        .pending_start_submission_count = "pendingStartSubmissionCount",
        .successful_cancel_submission_count = "successfulCancelSubmissionCount",
        .successful_delete_submission_count = "successfulDeleteSubmissionCount",
        .successful_start_submission_count = "successfulStartSubmissionCount",
    };
};
