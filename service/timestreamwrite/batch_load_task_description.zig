const DataModelConfiguration = @import("data_model_configuration.zig").DataModelConfiguration;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const BatchLoadProgressReport = @import("batch_load_progress_report.zig").BatchLoadProgressReport;
const ReportConfiguration = @import("report_configuration.zig").ReportConfiguration;
const BatchLoadStatus = @import("batch_load_status.zig").BatchLoadStatus;

/// Details about a batch load task.
pub const BatchLoadTaskDescription = struct {
    /// The time when the Timestream batch load task was created.
    creation_time: ?i64,

    /// Data model configuration for a batch load task. This contains details about
    /// where a data
    /// model for a batch load task is stored.
    data_model_configuration: ?DataModelConfiguration,

    /// Configuration details about the data source for a batch load task.
    data_source_configuration: ?DataSourceConfiguration,

    error_message: ?[]const u8,

    /// The time when the Timestream batch load task was last updated.
    last_updated_time: ?i64,

    progress_report: ?BatchLoadProgressReport,

    record_version: i64 = 0,

    /// Report configuration for a batch load task. This contains details about
    /// where error
    /// reports are stored.
    report_configuration: ?ReportConfiguration,

    resumable_until: ?i64,

    target_database_name: ?[]const u8,

    target_table_name: ?[]const u8,

    /// The ID of the batch load task.
    task_id: ?[]const u8,

    /// Status of the batch load task.
    task_status: ?BatchLoadStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_model_configuration = "DataModelConfiguration",
        .data_source_configuration = "DataSourceConfiguration",
        .error_message = "ErrorMessage",
        .last_updated_time = "LastUpdatedTime",
        .progress_report = "ProgressReport",
        .record_version = "RecordVersion",
        .report_configuration = "ReportConfiguration",
        .resumable_until = "ResumableUntil",
        .target_database_name = "TargetDatabaseName",
        .target_table_name = "TargetTableName",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
    };
};
