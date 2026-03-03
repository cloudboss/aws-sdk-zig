const TaskList = @import("task_list.zig").TaskList;

/// Provides the details of the `DecisionTaskCompleted` event.
pub const DecisionTaskCompletedEventAttributes = struct {
    /// User defined context for the workflow execution.
    execution_context: ?[]const u8 = null,

    /// The ID of the `DecisionTaskScheduled` event that was recorded when this
    /// decision task was scheduled.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `DecisionTaskStarted` event recorded when this decision task
    /// was started.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    started_event_id: i64 = 0,

    task_list: ?TaskList = null,

    /// The maximum amount of time the decision task can wait to be assigned to a
    /// worker.
    task_list_schedule_to_start_timeout: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_context = "executionContext",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
        .task_list = "taskList",
        .task_list_schedule_to_start_timeout = "taskListScheduleToStartTimeout",
    };
};
