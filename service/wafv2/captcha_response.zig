const FailureReason = @import("failure_reason.zig").FailureReason;

/// The result from the inspection of the web request for a valid `CAPTCHA`
/// token.
pub const CaptchaResponse = struct {
    /// The reason for failure, populated when the evaluation of the token fails.
    failure_reason: ?FailureReason = null,

    /// The HTTP response code indicating the status of the `CAPTCHA` token in the
    /// web request. If the token is missing, invalid, or expired, this code is `405
    /// Method
    /// Not Allowed`.
    response_code: ?i32 = null,

    /// The time that the `CAPTCHA` was last solved for the supplied token.
    solve_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .response_code = "ResponseCode",
        .solve_timestamp = "SolveTimestamp",
    };
};
