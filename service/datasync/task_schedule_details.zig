const ScheduleDisabledBy = @import("schedule_disabled_by.zig").ScheduleDisabledBy;

/// Provides information about your DataSync
/// [task
/// schedule](https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html).
pub const TaskScheduleDetails = struct {
    /// Indicates how your task schedule was disabled.
    ///
    /// * `USER` - Your schedule was manually disabled by using the
    ///   [UpdateTask](https://docs.aws.amazon.com/datasync/latest/userguide/API_UpdateTask.html) operation or DataSync console.
    ///
    /// * `SERVICE` - Your schedule was automatically disabled by DataSync
    /// because the task failed repeatedly with the same error.
    disabled_by: ?ScheduleDisabledBy,

    /// Provides a reason if the task schedule is disabled.
    ///
    /// If your schedule is disabled by `USER`, you see a `Manually disabled by
    /// user.` message.
    ///
    /// If your schedule is disabled by `SERVICE`, you see an error message to help
    /// you
    /// understand why the task keeps failing. For information on resolving DataSync
    /// errors,
    /// see [Troubleshooting issues with DataSync
    /// transfers](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-locations-tasks.html).
    disabled_reason: ?[]const u8,

    /// Indicates the last time the status of your task schedule changed. For
    /// example, if DataSync automatically disables your schedule because of a
    /// repeated error, you can see
    /// when the schedule was disabled.
    status_update_time: ?i64,

    pub const json_field_names = .{
        .disabled_by = "DisabledBy",
        .disabled_reason = "DisabledReason",
        .status_update_time = "StatusUpdateTime",
    };
};
