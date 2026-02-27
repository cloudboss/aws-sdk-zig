const ErrorObject = @import("error_object.zig").ErrorObject;

/// Details about a step operation.
pub const StepDetails = struct {
    /// The current attempt number for this step.
    attempt: i32 = 0,

    /// Details about the step failure.
    @"error": ?ErrorObject,

    /// The date and time when the next attempt is scheduled, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    /// Only populated when the step is in a pending state.
    next_attempt_timestamp: ?i64,

    /// The JSON response payload from the step operation.
    result: ?[]const u8,

    pub const json_field_names = .{
        .attempt = "Attempt",
        .@"error" = "Error",
        .next_attempt_timestamp = "NextAttemptTimestamp",
        .result = "Result",
    };
};
