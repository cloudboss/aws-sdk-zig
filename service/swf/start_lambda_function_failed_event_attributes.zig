const StartLambdaFunctionFailedCause = @import("start_lambda_function_failed_cause.zig").StartLambdaFunctionFailedCause;

/// Provides the details of the `StartLambdaFunctionFailed` event. It isn't set
/// for other event types.
pub const StartLambdaFunctionFailedEventAttributes = struct {
    /// The cause of the failure. To help diagnose issues, use this information to
    /// trace back the chain of events leading up to this event.
    ///
    /// If `cause` is set to `OPERATION_NOT_PERMITTED`, the decision
    /// failed because the IAM role attached to the execution lacked sufficient
    /// permissions. For
    /// details and example IAM policies, see [Lambda
    /// Tasks](https://docs.aws.amazon.com/amazonswf/latest/developerguide/lambda-task.html) in the
    /// *Amazon SWF Developer Guide*.
    cause: ?StartLambdaFunctionFailedCause,

    /// A description that can help diagnose the cause of the fault.
    message: ?[]const u8,

    /// The ID of the `ActivityTaskScheduled` event that was recorded when this
    /// activity task was scheduled. To help diagnose issues, use this information
    /// to trace back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    pub const json_field_names = .{
        .cause = "cause",
        .message = "message",
        .scheduled_event_id = "scheduledEventId",
    };
};
