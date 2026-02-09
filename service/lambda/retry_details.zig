/// Information about retry attempts for an operation.
pub const RetryDetails = struct {
    /// The current attempt number for this operation.
    current_attempt: ?i32,

    /// The delay before the next retry attempt, in seconds.
    next_attempt_delay_seconds: ?i32,
};
