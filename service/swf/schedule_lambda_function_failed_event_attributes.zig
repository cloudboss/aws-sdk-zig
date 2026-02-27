const ScheduleLambdaFunctionFailedCause = @import("schedule_lambda_function_failed_cause.zig").ScheduleLambdaFunctionFailedCause;

/// Provides the details of the `ScheduleLambdaFunctionFailed` event. It isn't
/// set for other event types.
pub const ScheduleLambdaFunctionFailedEventAttributes = struct {
    /// The cause of the failure. To help diagnose issues, use this information to
    /// trace back the chain of events leading up to this event.
    ///
    /// If `cause` is set to `OPERATION_NOT_PERMITTED`, the decision
    /// failed because it lacked sufficient permissions. For details and example IAM
    /// policies, see
    /// [Using
    /// IAM to Manage Access to Amazon SWF
    /// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the
    /// *Amazon SWF Developer Guide*.
    cause: ScheduleLambdaFunctionFailedCause,

    /// The ID of the `LambdaFunctionCompleted` event corresponding to the decision
    /// that resulted in scheduling this Lambda task. To help diagnose issues, use
    /// this information to trace back the chain of events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The ID provided in the `ScheduleLambdaFunction` decision that failed.
    id: []const u8,

    /// The name of the Lambda function.
    name: []const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .id = "id",
        .name = "name",
    };
};
