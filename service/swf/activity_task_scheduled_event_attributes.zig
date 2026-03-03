const ActivityType = @import("activity_type.zig").ActivityType;
const TaskList = @import("task_list.zig").TaskList;

/// Provides the details of the `ActivityTaskScheduled` event.
pub const ActivityTaskScheduledEventAttributes = struct {
    /// The unique ID of the activity task.
    activity_id: []const u8,

    /// The type of the activity task.
    activity_type: ActivityType,

    /// Data attached to the event that can be used by the decider in subsequent
    /// workflow tasks. This data isn't sent to the activity.
    control: ?[]const u8 = null,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// that resulted in the scheduling of this activity task. This information can
    /// be useful for diagnosing problems by tracing back the chain of events
    /// leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The maximum time before which the worker processing this task must report
    /// progress by calling
    /// RecordActivityTaskHeartbeat. If the timeout is exceeded, the activity task
    /// is automatically timed out. If
    /// the worker subsequently attempts to record a heartbeat or return a result,
    /// it is ignored.
    heartbeat_timeout: ?[]const u8 = null,

    /// The input provided to the activity task.
    input: ?[]const u8 = null,

    /// The maximum amount of time for this activity task.
    schedule_to_close_timeout: ?[]const u8 = null,

    /// The maximum amount of time the activity task can wait to be assigned to a
    /// worker.
    schedule_to_start_timeout: ?[]const u8 = null,

    /// The maximum amount of time a worker may take to process the activity task.
    start_to_close_timeout: ?[]const u8 = null,

    /// The task list in which the activity task has been scheduled.
    task_list: TaskList,

    /// The priority to assign to the scheduled activity task. If set, this
    /// overrides any default
    /// priority value that was assigned when the activity type was registered.
    ///
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8 = null,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .activity_type = "activityType",
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .heartbeat_timeout = "heartbeatTimeout",
        .input = "input",
        .schedule_to_close_timeout = "scheduleToCloseTimeout",
        .schedule_to_start_timeout = "scheduleToStartTimeout",
        .start_to_close_timeout = "startToCloseTimeout",
        .task_list = "taskList",
        .task_priority = "taskPriority",
    };
};
