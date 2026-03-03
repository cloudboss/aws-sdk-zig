/// Describes a scheduled scaling
/// action.
pub const ScheduledUpdateGroupAction = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The desired capacity is the initial capacity of the Auto Scaling group after
    /// the scheduled
    /// action runs and the capacity it attempts to maintain.
    desired_capacity: ?i32 = null,

    /// The date and time in UTC for the recurring schedule to end. For example,
    /// `"2019-06-01T00:00:00Z"`.
    end_time: ?i64 = null,

    /// The maximum size of the Auto Scaling group.
    max_size: ?i32 = null,

    /// The minimum size of the Auto Scaling group.
    min_size: ?i32 = null,

    /// The recurring schedule for the action, in Unix cron syntax format.
    ///
    /// When `StartTime` and `EndTime` are specified with
    /// `Recurrence`, they form the boundaries of when the recurring action
    /// starts and stops.
    recurrence: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the scheduled action.
    scheduled_action_arn: ?[]const u8 = null,

    /// The name of the scheduled action.
    scheduled_action_name: ?[]const u8 = null,

    /// The date and time in UTC for this action to start. For example,
    /// `"2019-06-01T00:00:00Z"`.
    start_time: ?i64 = null,

    /// This property is no longer used.
    time: ?i64 = null,

    /// The time zone for the cron expression.
    time_zone: ?[]const u8 = null,
};
