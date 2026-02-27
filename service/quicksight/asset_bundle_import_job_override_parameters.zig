const AssetBundleImportJobAnalysisOverrideParameters = @import("asset_bundle_import_job_analysis_override_parameters.zig").AssetBundleImportJobAnalysisOverrideParameters;
const AssetBundleImportJobDashboardOverrideParameters = @import("asset_bundle_import_job_dashboard_override_parameters.zig").AssetBundleImportJobDashboardOverrideParameters;
const AssetBundleImportJobDataSetOverrideParameters = @import("asset_bundle_import_job_data_set_override_parameters.zig").AssetBundleImportJobDataSetOverrideParameters;
const AssetBundleImportJobDataSourceOverrideParameters = @import("asset_bundle_import_job_data_source_override_parameters.zig").AssetBundleImportJobDataSourceOverrideParameters;
const AssetBundleImportJobFolderOverrideParameters = @import("asset_bundle_import_job_folder_override_parameters.zig").AssetBundleImportJobFolderOverrideParameters;
const AssetBundleImportJobRefreshScheduleOverrideParameters = @import("asset_bundle_import_job_refresh_schedule_override_parameters.zig").AssetBundleImportJobRefreshScheduleOverrideParameters;
const AssetBundleImportJobResourceIdOverrideConfiguration = @import("asset_bundle_import_job_resource_id_override_configuration.zig").AssetBundleImportJobResourceIdOverrideConfiguration;
const AssetBundleImportJobThemeOverrideParameters = @import("asset_bundle_import_job_theme_override_parameters.zig").AssetBundleImportJobThemeOverrideParameters;
const AssetBundleImportJobVPCConnectionOverrideParameters = @import("asset_bundle_import_job_vpc_connection_override_parameters.zig").AssetBundleImportJobVPCConnectionOverrideParameters;

/// A list of overrides that modify the asset bundle resource configuration
/// before the
/// resource is imported.
pub const AssetBundleImportJobOverrideParameters = struct {
    /// A list of overrides for any `Analysis` resources that are present in the
    /// asset bundle that is imported.
    analyses: ?[]const AssetBundleImportJobAnalysisOverrideParameters,

    /// A list of overrides for any `Dashboard` resources that are present in the
    /// asset bundle that is imported.
    dashboards: ?[]const AssetBundleImportJobDashboardOverrideParameters,

    /// A list of overrides for any `DataSet` resources that are present in the
    /// asset
    /// bundle that is imported.
    data_sets: ?[]const AssetBundleImportJobDataSetOverrideParameters,

    /// A list of overrides for any `DataSource` resources that are present in the
    /// asset bundle that is imported.
    data_sources: ?[]const AssetBundleImportJobDataSourceOverrideParameters,

    /// A list of overrides for any `Folder` resources that are present in the asset
    /// bundle that is imported.
    folders: ?[]const AssetBundleImportJobFolderOverrideParameters,

    /// A list of overrides for any `RefreshSchedule` resources that are present in
    /// the asset bundle that is imported.
    refresh_schedules: ?[]const AssetBundleImportJobRefreshScheduleOverrideParameters,

    /// An optional structure that configures resource ID overrides to be applied
    /// within the
    /// import job.
    resource_id_override_configuration: ?AssetBundleImportJobResourceIdOverrideConfiguration,

    /// A list of overrides for any `Theme` resources that are present in the asset
    /// bundle that is imported.
    themes: ?[]const AssetBundleImportJobThemeOverrideParameters,

    /// A list of overrides for any `VPCConnection` resources that are present in
    /// the
    /// asset bundle that is imported.
    vpc_connections: ?[]const AssetBundleImportJobVPCConnectionOverrideParameters,

    pub const json_field_names = .{
        .analyses = "Analyses",
        .dashboards = "Dashboards",
        .data_sets = "DataSets",
        .data_sources = "DataSources",
        .folders = "Folders",
        .refresh_schedules = "RefreshSchedules",
        .resource_id_override_configuration = "ResourceIdOverrideConfiguration",
        .themes = "Themes",
        .vpc_connections = "VPCConnections",
    };
};
