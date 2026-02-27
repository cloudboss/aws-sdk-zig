const DataAssetActivityStatus = @import("data_asset_activity_status.zig").DataAssetActivityStatus;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const LineageInfo = @import("lineage_info.zig").LineageInfo;

/// The activity details of the data source run.
pub const DataSourceRunActivity = struct {
    /// The timestamp of when data source run activity was created.
    created_at: i64,

    /// The identifier of the asset included in the data source run activity.
    data_asset_id: ?[]const u8,

    /// The status of the asset included in the data source run activity.
    data_asset_status: DataAssetActivityStatus,

    /// The database included in the data source run activity.
    database: []const u8,

    /// The identifier of the data source for the data source run activity.
    data_source_run_id: []const u8,

    error_message: ?DataSourceErrorMessage,

    /// The data lineage summary.
    lineage_summary: ?LineageInfo,

    /// The project ID included in the data source run activity.
    project_id: []const u8,

    /// The technical description included in the data source run activity.
    technical_description: ?[]const u8,

    /// The technical name included in the data source run activity.
    technical_name: []const u8,

    /// The timestamp of when data source run activity was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_asset_id = "dataAssetId",
        .data_asset_status = "dataAssetStatus",
        .database = "database",
        .data_source_run_id = "dataSourceRunId",
        .error_message = "errorMessage",
        .lineage_summary = "lineageSummary",
        .project_id = "projectId",
        .technical_description = "technicalDescription",
        .technical_name = "technicalName",
        .updated_at = "updatedAt",
    };
};
