const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;
const LambdaInvocationType = @import("lambda_invocation_type.zig").LambdaInvocationType;

/// The action to invoke an Amazon Web Services Lambda function for processing
/// the email.
pub const InvokeLambdaAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the Amazon Web Services
    /// Lambda function no longer exists.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The Amazon Resource Name (ARN) of the Lambda function to invoke.
    function_arn: []const u8,

    /// The invocation type of the Lambda function. Use EVENT for asynchronous
    /// invocation or REQUEST_RESPONSE for synchronous invocation.
    invocation_type: LambdaInvocationType,

    /// The maximum time in minutes that the email processing can be retried if the
    /// Lambda invocation fails. The maximum value is 2160 minutes (36 hours).
    retry_time_minutes: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to use to invoke the Lambda
    /// function.
    role_arn: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .function_arn = "FunctionArn",
        .invocation_type = "InvocationType",
        .retry_time_minutes = "RetryTimeMinutes",
        .role_arn = "RoleArn",
    };
};
