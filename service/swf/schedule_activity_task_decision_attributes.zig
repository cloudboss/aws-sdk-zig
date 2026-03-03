const ActivityType = @import("activity_type.zig").ActivityType;
const TaskList = @import("task_list.zig").TaskList;

/// Provides the details of the `ScheduleActivityTask` decision.
///
/// **Access Control**
///
/// You can use IAM policies to control this decision's access to Amazon SWF
/// resources as follows:
///
/// * Use a `Resource` element with the domain name to limit the action to only
/// specified domains.
///
/// * Use an `Action` element to allow or deny permission to call this action.
///
/// * Constrain the following parameters by using a `Condition` element with the
/// appropriate keys.
///
/// * `activityType.name` – String constraint. The key is
///   `swf:activityType.name`.
///
/// * `activityType.version` – String constraint. The key is
///   `swf:activityType.version`.
///
/// * `taskList` – String constraint. The key is `swf:taskList.name`.
///
/// If the caller doesn't have sufficient permissions to invoke the action, or
/// the
/// parameter values fall outside the specified constraints, the action fails.
/// The associated event attribute's
/// `cause` parameter is set to `OPERATION_NOT_PERMITTED`. For details and
/// example IAM policies, see
/// [Using IAM to Manage Access to Amazon SWF
/// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html)
/// in the *Amazon SWF Developer Guide*.
pub const ScheduleActivityTaskDecisionAttributes = struct {
    /// The `activityId` of the activity task.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    activity_id: []const u8,

    /// The type of the activity task to schedule.
    activity_type: ActivityType,

    /// Data attached to the event that can be used by the decider in subsequent
    /// workflow tasks. This data isn't sent to the activity.
    control: ?[]const u8 = null,

    /// If set, specifies the maximum time before which a worker processing a task
    /// of this type must report progress by
    /// calling RecordActivityTaskHeartbeat. If the timeout is exceeded, the
    /// activity task is automatically timed
    /// out. If the worker subsequently attempts to record a heartbeat or returns a
    /// result, it is ignored. This
    /// overrides the default heartbeat timeout specified when registering the
    /// activity type using
    /// RegisterActivityType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    heartbeat_timeout: ?[]const u8 = null,

    /// The input provided to the activity task.
    input: ?[]const u8 = null,

    /// The maximum duration for this activity task.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A schedule-to-close timeout for this activity task must be specified either
    /// as a default for the activity type or through this field. If neither this
    /// field is set nor a default schedule-to-close timeout was specified at
    /// registration time then a fault is returned.
    schedule_to_close_timeout: ?[]const u8 = null,

    /// If set, specifies the maximum duration the activity task can wait to be
    /// assigned to a worker.
    /// This overrides the default schedule-to-start timeout specified when
    /// registering the activity type using
    /// RegisterActivityType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A schedule-to-start timeout for this activity task must be specified either
    /// as a default for the activity type or through this field. If neither this
    /// field is set nor a default schedule-to-start timeout was specified at
    /// registration time then a fault is returned.
    schedule_to_start_timeout: ?[]const u8 = null,

    /// If set, specifies the maximum duration a worker may take to process this
    /// activity task. This overrides the
    /// default start-to-close timeout specified when registering the activity type
    /// using RegisterActivityType.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    ///
    /// A start-to-close timeout for this activity task must be specified either as
    /// a default for the activity type or through this field. If neither this field
    /// is set nor a default start-to-close timeout was specified at registration
    /// time then a fault is returned.
    start_to_close_timeout: ?[]const u8 = null,

    /// If set, specifies the name of the task list in which to schedule the
    /// activity task. If not specified, the
    /// `defaultTaskList` registered with the activity type is used.
    ///
    /// A task list for this activity task must be specified either as a default for
    /// the activity type or through this field. If neither this field is set nor a
    /// default task list was specified at registration time then a fault is
    /// returned.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    task_list: ?TaskList = null,

    /// If set, specifies the priority with which the activity task is to be
    /// assigned to a worker. This
    /// overrides the defaultTaskPriority specified when registering the activity
    /// type using RegisterActivityType.
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
        .heartbeat_timeout = "heartbeatTimeout",
        .input = "input",
        .schedule_to_close_timeout = "scheduleToCloseTimeout",
        .schedule_to_start_timeout = "scheduleToStartTimeout",
        .start_to_close_timeout = "startToCloseTimeout",
        .task_list = "taskList",
        .task_priority = "taskPriority",
    };
};
