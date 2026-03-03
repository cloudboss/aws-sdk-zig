const EnableSetting = @import("enable_setting.zig").EnableSetting;
const DataSourceErrorMessage = @import("data_source_error_message.zig").DataSourceErrorMessage;
const DataSourceRunStatus = @import("data_source_run_status.zig").DataSourceRunStatus;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// The details of the data source.
pub const DataSourceSummary = struct {
    /// The connection ID that's part of the data source summary.
    connection_id: ?[]const u8 = null,

    /// The timestamp of when the data source was created.
    created_at: ?i64 = null,

    /// The ID of the data source.
    data_source_id: []const u8,

    /// The data source description.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the data source exists.
    domain_id: []const u8,

    /// Specifies whether the data source is enabled.
    enable_setting: ?EnableSetting = null,

    /// The ID of the environment in which the data source exists.
    environment_id: ?[]const u8 = null,

    /// The count of the assets created during the last data source run.
    last_run_asset_count: ?i32 = null,

    /// The timestamp of when the data source run was last performed.
    last_run_at: ?i64 = null,

    last_run_error_message: ?DataSourceErrorMessage = null,

    /// The status of the last data source run.
    last_run_status: ?DataSourceRunStatus = null,

    /// The name of the data source.
    name: []const u8,

    schedule: ?ScheduleConfiguration = null,

    /// The status of the data source.
    status: DataSourceStatus,

    /// The type of the data source.
    @"type": []const u8,

    /// The timestamp of when the data source was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .connection_id = "connectionId",
        .created_at = "createdAt",
        .data_source_id = "dataSourceId",
        .description = "description",
        .domain_id = "domainId",
        .enable_setting = "enableSetting",
        .environment_id = "environmentId",
        .last_run_asset_count = "lastRunAssetCount",
        .last_run_at = "lastRunAt",
        .last_run_error_message = "lastRunErrorMessage",
        .last_run_status = "lastRunStatus",
        .name = "name",
        .schedule = "schedule",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
