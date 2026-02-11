/// Configuration options for a step operation.
pub const StepOptions = struct {
    /// The delay in seconds before the next retry attempt.
    next_attempt_delay_seconds: ?i32,

    pub const json_field_names = .{
        .next_attempt_delay_seconds = "NextAttemptDelaySeconds",
    };
};
