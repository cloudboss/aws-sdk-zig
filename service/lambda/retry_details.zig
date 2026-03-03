/// Information about retry attempts for an operation.
pub const RetryDetails = struct {
    /// The current attempt number for this operation.
    current_attempt: i32 = 0,

    /// The delay before the next retry attempt, in seconds.
    next_attempt_delay_seconds: ?i32 = null,

    pub const json_field_names = .{
        .current_attempt = "CurrentAttempt",
        .next_attempt_delay_seconds = "NextAttemptDelaySeconds",
    };
};
