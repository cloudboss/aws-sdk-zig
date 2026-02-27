const FailureReason = @import("failure_reason.zig").FailureReason;

/// The result from the inspection of the web request for a valid challenge
/// token.
pub const ChallengeResponse = struct {
    /// The reason for failure, populated when the evaluation of the token fails.
    failure_reason: ?FailureReason,

    /// The HTTP response code indicating the status of the challenge token in the
    /// web request. If the token is missing, invalid, or expired, this code is `202
    /// Request Accepted`.
    response_code: ?i32,

    /// The time that the challenge was last solved for the supplied token.
    solve_timestamp: ?i64,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .response_code = "ResponseCode",
        .solve_timestamp = "SolveTimestamp",
    };
};
