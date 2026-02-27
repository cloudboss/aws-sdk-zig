const TaskList = @import("task_list.zig").TaskList;

/// Configuration settings registered with the activity type.
pub const ActivityTypeConfiguration = struct {
    /// The default maximum time, in seconds, before which a worker processing a
    /// task must report
    /// progress by calling RecordActivityTaskHeartbeat.
    ///
    /// You can specify this value only when *registering* an activity type. The
    /// registered default value can be
    /// overridden when you schedule a task through the `ScheduleActivityTask`
    /// Decision. If the activity
    /// worker subsequently attempts to record a heartbeat or returns a result, the
    /// activity worker receives an
    /// `UnknownResource` fault. In this case, Amazon SWF no longer considers the
    /// activity task to be valid;
    /// the activity worker should clean up the activity task.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_heartbeat_timeout: ?[]const u8,

    /// The default task list specified for this activity type at registration. This
    /// default is used if
    /// a task list isn't provided when a task is scheduled through the
    /// `ScheduleActivityTask`
    /// Decision. You can override the default registered task list when scheduling
    /// a task through the
    /// `ScheduleActivityTask`
    /// Decision.
    default_task_list: ?TaskList,

    /// The default task priority for tasks of this activity type, specified at
    /// registration. If not
    /// set, then `0` is used as the default priority. This default can be
    /// overridden when scheduling an activity
    /// task.
    ///
    /// Valid values are integers that range from Java's `Integer.MIN_VALUE`
    /// (-2147483648) to `Integer.MAX_VALUE` (2147483647). Higher numbers indicate
    /// higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *Amazon SWF Developer Guide*.
    default_task_priority: ?[]const u8,

    /// The default maximum duration, specified when registering the activity type,
    /// for tasks of this activity
    /// type. You can override this default when scheduling a task through the
    /// `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_schedule_to_close_timeout: ?[]const u8,

    /// The default maximum duration, specified when registering the activity type,
    /// that a task of an
    /// activity type can wait before being assigned to a worker. You can override
    /// this default when scheduling a task
    /// through the `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_schedule_to_start_timeout: ?[]const u8,

    /// The default maximum duration for tasks of an activity type specified when
    /// registering the activity
    /// type. You can override this default when scheduling a task through the
    /// `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_start_to_close_timeout: ?[]const u8,

    pub const json_field_names = .{
        .default_task_heartbeat_timeout = "defaultTaskHeartbeatTimeout",
        .default_task_list = "defaultTaskList",
        .default_task_priority = "defaultTaskPriority",
        .default_task_schedule_to_close_timeout = "defaultTaskScheduleToCloseTimeout",
        .default_task_schedule_to_start_timeout = "defaultTaskScheduleToStartTimeout",
        .default_task_start_to_close_timeout = "defaultTaskStartToCloseTimeout",
    };
};
