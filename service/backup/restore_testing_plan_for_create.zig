const RestoreTestingRecoveryPointSelection = @import("restore_testing_recovery_point_selection.zig").RestoreTestingRecoveryPointSelection;

/// This contains metadata about a restore testing plan.
pub const RestoreTestingPlanForCreate = struct {
    /// `RecoveryPointSelection` has five parameters (three required and two
    /// optional). The values you specify determine which recovery point is included
    /// in the restore
    /// test. You must indicate with `Algorithm` if you want the latest recovery
    /// point
    /// within your `SelectionWindowDays` or if you want a random recovery point,
    /// and
    /// you must indicate through `IncludeVaults` from which vaults the recovery
    /// points
    /// can be chosen.
    ///
    /// `Algorithm` (*required*) Valid values:
    /// "`LATEST_WITHIN_WINDOW`" or "`RANDOM_WITHIN_WINDOW`".
    ///
    /// `Recovery point types` (*required*) Valid values:
    /// "`SNAPSHOT`" and/or "`CONTINUOUS`". Include `SNAPSHOT`
    /// to restore only snapshot recovery points; include `CONTINUOUS` to restore
    /// continuous recovery points (point in time restore / PITR); use both to
    /// restore either a
    /// snapshot or a continuous recovery point. The recovery point will be
    /// determined by the value
    /// for `Algorithm`.
    ///
    /// `IncludeVaults` (*required*). You must include one or more
    /// backup vaults. Use the wildcard ["*"] or specific ARNs.
    ///
    /// `SelectionWindowDays` (*optional*) Value must be an
    /// integer (in days) from 1 to 365. If not included, the value defaults to
    /// `30`.
    ///
    /// `ExcludeVaults` (*optional*). You can choose to input one
    /// or more specific backup vault ARNs to exclude those vaults' contents from
    /// restore
    /// eligibility. Or, you can include a list of selectors. If this parameter and
    /// its value are
    /// not included, it defaults to empty list.
    recovery_point_selection: RestoreTestingRecoveryPointSelection,

    /// The RestoreTestingPlanName is a unique string that is the name
    /// of the restore testing plan. This cannot be changed after creation,
    /// and it must consist of only alphanumeric characters and underscores.
    restore_testing_plan_name: []const u8,

    /// A CRON expression in specified timezone when a restore
    /// testing plan is executed. When no CRON expression is provided, Backup will
    /// use the default
    /// expression `cron(0 5 ? * * *)`.
    schedule_expression: []const u8,

    /// Optional. This is the timezone in which the schedule
    /// expression is set. By default, ScheduleExpressions are in UTC.
    /// You can modify this to a specified timezone.
    schedule_expression_timezone: ?[]const u8,

    /// Defaults to 24 hours.
    ///
    /// A value in hours after a
    /// restore test is scheduled before a job will be canceled if it
    /// doesn't start successfully. This value is optional. If this value
    /// is included, this parameter has a maximum value of 168 hours
    /// (one week).
    start_window_hours: i32 = 0,

    pub const json_field_names = .{
        .recovery_point_selection = "RecoveryPointSelection",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .schedule_expression = "ScheduleExpression",
        .schedule_expression_timezone = "ScheduleExpressionTimezone",
        .start_window_hours = "StartWindowHours",
    };
};
