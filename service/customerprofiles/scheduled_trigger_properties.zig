const DataPullMode = @import("data_pull_mode.zig").DataPullMode;

/// Specifies the configuration details of a scheduled-trigger flow that you
/// define.
/// Currently, these settings only apply to the scheduled-trigger type.
pub const ScheduledTriggerProperties = struct {
    /// Specifies whether a scheduled flow has an incremental data transfer or a
    /// complete data
    /// transfer for each flow run.
    data_pull_mode: ?DataPullMode,

    /// Specifies the date range for the records to import from the connector in the
    /// first flow
    /// run.
    first_execution_from: ?i64,

    /// Specifies the scheduled end time for a scheduled-trigger flow.
    schedule_end_time: ?i64,

    /// The scheduling expression that determines the rate at which the schedule
    /// will run, for
    /// example rate (5 minutes).
    schedule_expression: []const u8,

    /// Specifies the optional offset that is added to the time interval for a
    /// schedule-triggered flow.
    schedule_offset: ?i64,

    /// Specifies the scheduled start time for a scheduled-trigger flow.
    schedule_start_time: ?i64,

    /// Specifies the time zone used when referring to the date and time of a
    /// scheduled-triggered flow, such as America/New_York.
    timezone: ?[]const u8,

    pub const json_field_names = .{
        .data_pull_mode = "DataPullMode",
        .first_execution_from = "FirstExecutionFrom",
        .schedule_end_time = "ScheduleEndTime",
        .schedule_expression = "ScheduleExpression",
        .schedule_offset = "ScheduleOffset",
        .schedule_start_time = "ScheduleStartTime",
        .timezone = "Timezone",
    };
};
