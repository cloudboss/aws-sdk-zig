const ExecutionAttempt = @import("execution_attempt.zig").ExecutionAttempt;
const Schedule = @import("schedule.zig").Schedule;
const ScheduleType = @import("schedule_type.zig").ScheduleType;
const SettingSource = @import("setting_source.zig").SettingSource;

/// The settings for a column statistics task.
pub const ColumnStatisticsTaskSettings = struct {
    /// The ID of the Data Catalog in which the database resides.
    catalog_id: ?[]const u8,

    /// A list of column names for which to run statistics.
    column_name_list: ?[]const []const u8,

    /// The name of the database where the table resides.
    database_name: ?[]const u8,

    /// The last `ExecutionAttempt` for the column statistics task run.
    last_execution_attempt: ?ExecutionAttempt,

    /// The role used for running the column statistics.
    role: ?[]const u8,

    /// The percentage of data to sample.
    sample_size: f64 = 0,

    /// A schedule for running the column statistics, specified in CRON syntax.
    schedule: ?Schedule,

    /// The type of schedule for a column statistics task. Possible values may be
    /// `CRON` or `AUTO`.
    schedule_type: ?ScheduleType,

    /// Name of the security configuration that is used to encrypt CloudWatch logs.
    security_configuration: ?[]const u8,

    /// The source of setting the column statistics task. Possible values may be
    /// `CATALOG` or `TABLE`.
    setting_source: ?SettingSource,

    /// The name of the table for which to generate column statistics.
    table_name: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogID",
        .column_name_list = "ColumnNameList",
        .database_name = "DatabaseName",
        .last_execution_attempt = "LastExecutionAttempt",
        .role = "Role",
        .sample_size = "SampleSize",
        .schedule = "Schedule",
        .schedule_type = "ScheduleType",
        .security_configuration = "SecurityConfiguration",
        .setting_source = "SettingSource",
        .table_name = "TableName",
    };
};
