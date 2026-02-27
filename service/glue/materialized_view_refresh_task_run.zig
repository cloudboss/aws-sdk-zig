const MaterializedViewRefreshType = @import("materialized_view_refresh_type.zig").MaterializedViewRefreshType;
const MaterializedViewRefreshState = @import("materialized_view_refresh_state.zig").MaterializedViewRefreshState;

/// The object that shows the details of the materialized view refresh task run.
pub const MaterializedViewRefreshTaskRun = struct {
    /// The ID of the Data Catalog where the table resides. If none is supplied, the
    /// account ID is used by default.
    catalog_id: ?[]const u8,

    /// The time that this task was created.
    creation_time: ?i64,

    /// The Amazon Web Services account ID.
    customer_id: ?[]const u8,

    /// The database where the table resides.
    database_name: ?[]const u8,

    /// The calculated DPU usage in seconds for all autoscaled workers.
    dpu_seconds: f64 = 0,

    /// The end time of the task.
    end_time: ?i64,

    /// The error message for the job.
    error_message: ?[]const u8,

    /// The last point in time when this task was modified.
    last_updated: ?i64,

    /// The identifier of the materialized view refresh task run.
    materialized_view_refresh_task_run_id: ?[]const u8,

    /// The number of bytes the refresh task run has scanned to refresh the
    /// materialized view.
    processed_bytes: ?i64,

    /// The type of the refresh task run. Either FULL or INCREMENTAL.
    refresh_type: ?MaterializedViewRefreshType,

    /// The IAM role that the service assumes to generate statistics.
    role: ?[]const u8,

    /// The start time of the task.
    start_time: ?i64,

    /// The status of the task run.
    status: ?MaterializedViewRefreshState,

    /// The name of the table for which statistics is generated.
    table_name: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .creation_time = "CreationTime",
        .customer_id = "CustomerId",
        .database_name = "DatabaseName",
        .dpu_seconds = "DPUSeconds",
        .end_time = "EndTime",
        .error_message = "ErrorMessage",
        .last_updated = "LastUpdated",
        .materialized_view_refresh_task_run_id = "MaterializedViewRefreshTaskRunId",
        .processed_bytes = "ProcessedBytes",
        .refresh_type = "RefreshType",
        .role = "Role",
        .start_time = "StartTime",
        .status = "Status",
        .table_name = "TableName",
    };
};
