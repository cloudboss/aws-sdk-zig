const LambdaFunctionTimeoutType = @import("lambda_function_timeout_type.zig").LambdaFunctionTimeoutType;

/// Provides details of the `LambdaFunctionTimedOut` event.
pub const LambdaFunctionTimedOutEventAttributes = struct {
    /// The ID of the `LambdaFunctionScheduled` event that was recorded when this
    /// activity task was scheduled. To help diagnose issues, use this information
    /// to trace back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `ActivityTaskStarted` event that was recorded when this
    /// activity task started. To help diagnose issues, use this information to
    /// trace back the chain of events leading up to this event.
    started_event_id: i64 = 0,

    /// The type of the timeout that caused this event.
    timeout_type: ?LambdaFunctionTimeoutType = null,

    pub const json_field_names = .{
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
        .timeout_type = "timeoutType",
    };
};
