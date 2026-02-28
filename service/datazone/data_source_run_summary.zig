const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const DataSourceRunLineageSummary = @import("data_source_run_lineage_summary.zig").DataSourceRunLineageSummary;
const RunStatisticsForAssets = @import("run_statistics_for_assets.zig").RunStatisticsForAssets;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const DataSourceRunType = @import("data_source_run_type.zig").DataSourceRunType;

/// The details of a data source run.
pub const DataSourceRunSummary = struct {
    /// The timestamp of when a data source run was created.
    created_at: i64,

    /// The identifier of the data source of the data source run.
    data_source_id: []const u8,

    error_message: ?DataSourceErrorMessage,

    /// The identifier of the data source run.
    id: []const u8,

    /// The run lineage summary of a data source.
    lineage_summary: ?DataSourceRunLineageSummary,

    /// The project ID of the data source run.
    project_id: []const u8,

    run_statistics_for_assets: ?RunStatisticsForAssets,

    /// The timestamp of when a data source run was started.
    started_at: ?i64,

    /// The status of the data source run.
    status: DataSourceRunStatus,

    /// The timestamp of when a data source run was stopped.
    stopped_at: ?i64,

    /// The type of the data source run.
    @"type": DataSourceRunType,

    /// The timestamp of when a data source run was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_source_id = "dataSourceId",
        .error_message = "errorMessage",
        .id = "id",
        .lineage_summary = "lineageSummary",
        .project_id = "projectId",
        .run_statistics_for_assets = "runStatisticsForAssets",
        .started_at = "startedAt",
        .status = "status",
        .stopped_at = "stoppedAt",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
