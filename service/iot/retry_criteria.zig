const RetryableFailureType = @import("retryable_failure_type.zig").RetryableFailureType;

/// The criteria that determines how many retries are allowed for each failure
/// type for a
/// job.
pub const RetryCriteria = struct {
    /// The type of job execution failures that can initiate a job retry.
    failure_type: RetryableFailureType,

    /// The number of retries allowed for a failure type for the job.
    number_of_retries: i32,

    pub const json_field_names = .{
        .failure_type = "failureType",
        .number_of_retries = "numberOfRetries",
    };
};
