const JobEndBehavior = @import("job_end_behavior.zig").JobEndBehavior;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;

/// Specifies the date and time that a job will begin the rollout of the job
/// document to
/// all devices in the target group. Additionally, you can specify the end
/// behavior for each
/// job execution when it reaches the scheduled end time.
pub const SchedulingConfig = struct {
    /// Specifies the end behavior for all job executions after a job reaches the
    /// selected
    /// `endTime`. If `endTime` is not selected when creating the job,
    /// then `endBehavior` does not apply.
    end_behavior: ?JobEndBehavior,

    /// The time a job will stop rollout of the job document to all devices in the
    /// target
    /// group for a job. The `endTime` must take place no later than two years from
    /// the current time and be scheduled a minimum of thirty minutes from the
    /// current time. The
    /// minimum duration between `startTime` and `endTime` is thirty
    /// minutes. The maximum duration between `startTime` and `endTime` is
    /// two years. The date and time format for the `endTime` is YYYY-MM-DD for the
    /// date and HH:MM for the time.
    ///
    /// For more information on the syntax for `endTime` when using an API command
    /// or the Command Line Interface, see
    /// [Timestamp](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp).
    end_time: ?[]const u8,

    /// An optional configuration within the `SchedulingConfig` to setup a
    /// recurring maintenance window with a predetermined start time and duration
    /// for the
    /// rollout of a job document to all devices in a target group for a job.
    maintenance_windows: ?[]const MaintenanceWindow,

    /// The time a job will begin rollout of the job document to all devices in the
    /// target
    /// group for a job. The `startTime` can be scheduled up to a year in advance
    /// and
    /// must be scheduled a minimum of thirty minutes from the current time. The
    /// date and time
    /// format for the `startTime` is YYYY-MM-DD for the date and HH:MM for the
    /// time.
    ///
    /// For more information on the syntax for `startTime` when using an API
    /// command or the Command Line Interface, see
    /// [Timestamp](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp).
    start_time: ?[]const u8,

    pub const json_field_names = .{
        .end_behavior = "endBehavior",
        .end_time = "endTime",
        .maintenance_windows = "maintenanceWindows",
        .start_time = "startTime",
    };
};
