/// A `RetryPolicy` object that includes information about the retry policy
/// settings.
pub const RetryPolicy = struct {
    /// The maximum amount of time, in seconds, to continue to make retry attempts.
    maximum_event_age_in_seconds: ?i32,

    /// The maximum number of retry attempts to make before the request fails. Retry
    /// attempts
    /// continue until either the maximum number of attempts is made or until the
    /// duration of the
    /// `MaximumEventAgeInSeconds` is met.
    maximum_retry_attempts: ?i32,

    pub const json_field_names = .{
        .maximum_event_age_in_seconds = "MaximumEventAgeInSeconds",
        .maximum_retry_attempts = "MaximumRetryAttempts",
    };
};
