const DataPullMode = @import("data_pull_mode.zig").DataPullMode;

/// Specifies the configuration details of a schedule-triggered flow as defined
/// by the user.
/// Currently, these settings only apply to the `Scheduled` trigger type.
pub const ScheduledTriggerProperties = struct {
    /// Specifies whether a scheduled flow has an incremental data transfer or a
    /// complete data
    /// transfer for each flow run.
    data_pull_mode: ?DataPullMode = null,

    /// Specifies the date range for the records to import from the connector in the
    /// first flow
    /// run.
    first_execution_from: ?i64 = null,

    /// Defines how many times a scheduled flow fails consecutively before Amazon
    /// AppFlow
    /// deactivates it.
    flow_error_deactivation_threshold: ?i32 = null,

    /// The time at which the scheduled flow ends. The time is formatted as a
    /// timestamp that
    /// follows the ISO 8601 standard, such as `2022-04-27T13:00:00-07:00`.
    schedule_end_time: ?i64 = null,

    /// The scheduling expression that determines the rate at which the schedule
    /// will run, for
    /// example `rate(5minutes)`.
    schedule_expression: []const u8,

    /// Specifies the optional offset that is added to the time interval for a
    /// schedule-triggered
    /// flow.
    schedule_offset: ?i64 = null,

    /// The time at which the scheduled flow starts. The time is formatted as a
    /// timestamp that
    /// follows the ISO 8601 standard, such as `2022-04-26T13:00:00-07:00`.
    schedule_start_time: ?i64 = null,

    /// Specifies the time zone used when referring to the dates and times of a
    /// scheduled flow,
    /// such as `America/New_York`. This time zone is only a descriptive label. It
    /// doesn't
    /// affect how Amazon AppFlow interprets the timestamps that you specify to
    /// schedule the
    /// flow.
    ///
    /// If you want to schedule a flow by using times in a particular time zone,
    /// indicate the time
    /// zone as a UTC offset in your timestamps. For example, the UTC offsets for
    /// the
    /// `America/New_York` timezone are `-04:00` EDT and `-05:00
    /// EST`.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_pull_mode = "dataPullMode",
        .first_execution_from = "firstExecutionFrom",
        .flow_error_deactivation_threshold = "flowErrorDeactivationThreshold",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_offset = "scheduleOffset",
        .schedule_start_time = "scheduleStartTime",
        .timezone = "timezone",
    };
};
