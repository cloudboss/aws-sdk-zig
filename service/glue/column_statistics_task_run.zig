const ComputationType = @import("computation_type.zig").ComputationType;
const ColumnStatisticsState = @import("column_statistics_state.zig").ColumnStatisticsState;

/// The object that shows the details of the column stats run.
pub const ColumnStatisticsTaskRun = struct {
    /// The ID of the Data Catalog where the table resides. If none is supplied, the
    /// Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// A list of the column names. If none is supplied, all column names for the
    /// table will be used by default.
    column_name_list: ?[]const []const u8 = null,

    /// The identifier for the particular column statistics task run.
    column_statistics_task_run_id: ?[]const u8 = null,

    /// The type of column statistics computation.
    computation_type: ?ComputationType = null,

    /// The time that this task was created.
    creation_time: ?i64 = null,

    /// The Amazon Web Services account ID.
    customer_id: ?[]const u8 = null,

    /// The database where the table resides.
    database_name: ?[]const u8 = null,

    /// The calculated DPU usage in seconds for all autoscaled workers.
    dpu_seconds: f64 = 0,

    /// The end time of the task.
    end_time: ?i64 = null,

    /// The error message for the job.
    error_message: ?[]const u8 = null,

    /// The last point in time when this task was modified.
    last_updated: ?i64 = null,

    /// The number of workers used to generate column statistics. The job is
    /// preconfigured to autoscale up to 25 instances.
    number_of_workers: i32 = 0,

    /// The IAM role that the service assumes to generate statistics.
    role: ?[]const u8 = null,

    /// The percentage of rows used to generate statistics. If none is supplied, the
    /// entire table will be used to generate stats.
    sample_size: f64 = 0,

    /// Name of the security configuration that is used to encrypt CloudWatch logs
    /// for the column stats task run.
    security_configuration: ?[]const u8 = null,

    /// The start time of the task.
    start_time: ?i64 = null,

    /// The status of the task run.
    status: ?ColumnStatisticsState = null,

    /// The name of the table for which column statistics is generated.
    table_name: ?[]const u8 = null,

    /// The type of workers being used for generating stats. The default is `g.1x`.
    worker_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogID",
        .column_name_list = "ColumnNameList",
        .column_statistics_task_run_id = "ColumnStatisticsTaskRunId",
        .computation_type = "ComputationType",
        .creation_time = "CreationTime",
        .customer_id = "CustomerId",
        .database_name = "DatabaseName",
        .dpu_seconds = "DPUSeconds",
        .end_time = "EndTime",
        .error_message = "ErrorMessage",
        .last_updated = "LastUpdated",
        .number_of_workers = "NumberOfWorkers",
        .role = "Role",
        .sample_size = "SampleSize",
        .security_configuration = "SecurityConfiguration",
        .start_time = "StartTime",
        .status = "Status",
        .table_name = "TableName",
        .worker_type = "WorkerType",
    };
};
