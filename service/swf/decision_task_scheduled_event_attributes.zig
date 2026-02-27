const TaskList = @import("task_list.zig").TaskList;

/// Provides details about the `DecisionTaskScheduled` event.
pub const DecisionTaskScheduledEventAttributes = struct {
    /// The maximum amount of time the decision task can wait to be assigned to a
    /// worker.
    schedule_to_start_timeout: ?[]const u8,

    /// The maximum duration for this decision task. The task is considered timed
    /// out if it doesn't completed within this duration.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    start_to_close_timeout: ?[]const u8,

    /// The name of the task list in which the decision task was scheduled.
    task_list: TaskList,

    /// A task priority that, if set, specifies the priority for this decision task.
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    task_priority: ?[]const u8,

    pub const json_field_names = .{
        .schedule_to_start_timeout = "scheduleToStartTimeout",
        .start_to_close_timeout = "startToCloseTimeout",
        .task_list = "taskList",
        .task_priority = "taskPriority",
    };
};
