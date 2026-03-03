/// A `RetryPolicy` object that includes information about the retry policy
/// settings, including the maximum age of an event, and the maximum number of
/// times EventBridge Scheduler will try to deliver the event to a target.
pub const RetryPolicy = struct {
    /// The maximum amount of time, in seconds, to continue to make retry attempts.
    maximum_event_age_in_seconds: ?i32 = null,

    /// The maximum number of retry attempts to make before the request fails. Retry
    /// attempts with exponential backoff continue until either the maximum number
    /// of attempts is made or
    /// until the duration of the `MaximumEventAgeInSeconds` is reached.
    maximum_retry_attempts: ?i32 = null,

    pub const json_field_names = .{
        .maximum_event_age_in_seconds = "MaximumEventAgeInSeconds",
        .maximum_retry_attempts = "MaximumRetryAttempts",
    };
};
