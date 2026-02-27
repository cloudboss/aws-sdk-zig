/// Provides the details of the `ActivityTaskCancelRequested` event.
pub const ActivityTaskCancelRequestedEventAttributes = struct {
    /// The unique ID of the task.
    activity_id: []const u8,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `RequestCancelActivityTask` decision for this cancellation request. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
    };
};
