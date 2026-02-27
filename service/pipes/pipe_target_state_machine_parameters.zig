const PipeTargetInvocationType = @import("pipe_target_invocation_type.zig").PipeTargetInvocationType;

/// The parameters for using a Step Functions state machine as a target.
pub const PipeTargetStateMachineParameters = struct {
    /// Specify whether to invoke the Step Functions state machine synchronously or
    /// asynchronously.
    ///
    /// * `REQUEST_RESPONSE` (default) - Invoke synchronously. For more
    /// information, see
    /// [StartSyncExecution](https://docs.aws.amazon.com/step-functions/latest/apireference/API_StartSyncExecution.html) in the *Step Functions API
    /// Reference*.
    ///
    /// `REQUEST_RESPONSE` is not supported for `STANDARD` state
    /// machine workflows.
    ///
    /// * `FIRE_AND_FORGET` - Invoke asynchronously. For more information, see
    /// [StartExecution](https://docs.aws.amazon.com/step-functions/latest/apireference/API_StartExecution.html) in the *Step Functions API
    /// Reference*.
    ///
    /// For more information, see [Invocation
    /// types](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html#pipes-invocation) in the *Amazon EventBridge User Guide*.
    invocation_type: ?PipeTargetInvocationType,

    pub const json_field_names = .{
        .invocation_type = "InvocationType",
    };
};
