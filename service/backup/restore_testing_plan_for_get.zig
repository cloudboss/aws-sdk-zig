const RestoreTestingRecoveryPointSelection = @import("restore_testing_recovery_point_selection.zig").RestoreTestingRecoveryPointSelection;

/// This contains metadata about a restore testing plan.
pub const RestoreTestingPlanForGet = struct {
    /// The date and time that a restore testing plan was created,
    /// in Unix format and Coordinated Universal Time (UTC). The value of
    /// `CreationTime` is accurate to milliseconds. For example,
    /// the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087 AM.
    creation_time: i64,

    /// This identifies the request and allows failed requests to
    /// be retried without the risk of running the operation twice.
    /// If the request includes a `CreatorRequestId` that
    /// matches an existing backup plan, that plan is returned. This
    /// parameter is optional.
    ///
    /// If used, this parameter must
    /// contain 1 to 50 alphanumeric or '-_.' characters.
    creator_request_id: ?[]const u8 = null,

    /// The last time a restore test was run with the specified
    /// restore testing plan. A date and time, in Unix format and
    /// Coordinated Universal Time (UTC). The value of
    /// `LastExecutionDate` is accurate to milliseconds.
    /// For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    last_execution_time: ?i64 = null,

    /// The date and time that the restore testing plan was updated.
    /// This update is in Unix format and Coordinated Universal Time (UTC).
    /// The value of `LastUpdateTime` is accurate to milliseconds.
    /// For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    last_update_time: ?i64 = null,

    /// The specified criteria to assign a set of resources, such as
    /// recovery point types or backup vaults.
    recovery_point_selection: RestoreTestingRecoveryPointSelection,

    /// An Amazon Resource Name (ARN) that uniquely identifies
    /// a restore testing plan.
    restore_testing_plan_arn: []const u8,

    /// The restore testing plan name.
    restore_testing_plan_name: []const u8,

    /// A CRON expression in specified timezone when a restore
    /// testing plan is executed. When no CRON expression is provided, Backup will
    /// use the default
    /// expression `cron(0 5 ? * * *)`.
    schedule_expression: []const u8,

    /// Optional. This is the timezone in which the schedule
    /// expression is set. By default, ScheduleExpressions are in UTC.
    /// You can modify this to a specified timezone.
    schedule_expression_timezone: ?[]const u8 = null,

    /// Defaults to 24 hours.
    ///
    /// A value in hours after a
    /// restore test is scheduled before a job will be canceled if it
    /// doesn't start successfully. This value is optional. If this value
    /// is included, this parameter has a maximum value of 168 hours
    /// (one week).
    start_window_hours: i32 = 0,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .last_execution_time = "LastExecutionTime",
        .last_update_time = "LastUpdateTime",
        .recovery_point_selection = "RecoveryPointSelection",
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .schedule_expression = "ScheduleExpression",
        .schedule_expression_timezone = "ScheduleExpressionTimezone",
        .start_window_hours = "StartWindowHours",
    };
};
