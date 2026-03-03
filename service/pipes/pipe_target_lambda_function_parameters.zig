const PipeTargetInvocationType = @import("pipe_target_invocation_type.zig").PipeTargetInvocationType;

/// The parameters for using a Lambda function as a target.
pub const PipeTargetLambdaFunctionParameters = struct {
    /// Specify whether to invoke the function synchronously or asynchronously.
    ///
    /// * `REQUEST_RESPONSE` (default) - Invoke synchronously. This corresponds
    /// to the `RequestResponse` option in the `InvocationType`
    /// parameter for the Lambda
    /// [Invoke](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html#API_Invoke_RequestSyntax)
    /// API.
    ///
    /// * `FIRE_AND_FORGET` - Invoke asynchronously. This corresponds to the
    /// `Event` option in the `InvocationType` parameter for the
    /// Lambda
    /// [Invoke](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html#API_Invoke_RequestSyntax)
    /// API.
    ///
    /// For more information, see [Invocation
    /// types](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html#pipes-invocation) in the *Amazon EventBridge User Guide*.
    invocation_type: ?PipeTargetInvocationType = null,

    pub const json_field_names = .{
        .invocation_type = "InvocationType",
    };
};
