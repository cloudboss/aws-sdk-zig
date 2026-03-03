const RestoreTestingRecoveryPointSelection = @import("restore_testing_recovery_point_selection.zig").RestoreTestingRecoveryPointSelection;

/// This contains metadata about a restore testing plan.
pub const RestoreTestingPlanForUpdate = struct {
    /// Required: `Algorithm`; `RecoveryPointTypes`;
    /// `IncludeVaults` (*one or more*).
    ///
    /// Optional: *SelectionWindowDays* (*'30' if
    /// not specified*); `ExcludeVaults` (defaults to empty
    /// list if not listed).
    recovery_point_selection: ?RestoreTestingRecoveryPointSelection = null,

    /// A CRON expression in specified timezone when a restore testing plan is
    /// executed. When no
    /// CRON expression is provided, Backup will use the default expression
    /// `cron(0 5 ? * * *)`.
    schedule_expression: ?[]const u8 = null,

    /// Optional. This is the timezone in which the schedule
    /// expression is set. By default, ScheduleExpressions are in UTC.
    /// You can modify this to a specified timezone.
    schedule_expression_timezone: ?[]const u8 = null,

    /// Defaults to 24 hours.
    ///
    /// A value in hours after a restore test is scheduled before a
    /// job will be canceled if it doesn't start successfully. This value
    /// is optional. If this value is included, this parameter has a
    /// maximum value of 168 hours (one week).
    start_window_hours: i32 = 0,

    pub const json_field_names = .{
        .recovery_point_selection = "RecoveryPointSelection",
        .schedule_expression = "ScheduleExpression",
        .schedule_expression_timezone = "ScheduleExpressionTimezone",
        .start_window_hours = "StartWindowHours",
    };
};
