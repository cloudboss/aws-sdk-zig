const HarnessHookFailureMode = @import("harness_hook_failure_mode.zig").HarnessHookFailureMode;

/// The configuration for an AWS Lambda hook target.
pub const HarnessHookLambdaTarget = struct {
    /// The ARN of the Lambda function to invoke.
    arn: []const u8,

    /// The behavior when the Lambda function times out, returns an error, or
    /// returns an invalid response. The default is `DENY`.
    failure_mode: HarnessHookFailureMode = .deny,

    /// The maximum number of seconds to wait for the Lambda function response. The
    /// default is 60 seconds.
    timeout_seconds: i32 = 60,

    pub const json_field_names = .{
        .arn = "arn",
        .failure_mode = "failureMode",
        .timeout_seconds = "timeoutSeconds",
    };
};
