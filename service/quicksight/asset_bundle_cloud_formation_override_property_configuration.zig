const AssetBundleExportJobAnalysisOverrideProperties = @import("asset_bundle_export_job_analysis_override_properties.zig").AssetBundleExportJobAnalysisOverrideProperties;
const AssetBundleExportJobDashboardOverrideProperties = @import("asset_bundle_export_job_dashboard_override_properties.zig").AssetBundleExportJobDashboardOverrideProperties;
const AssetBundleExportJobDataSetOverrideProperties = @import("asset_bundle_export_job_data_set_override_properties.zig").AssetBundleExportJobDataSetOverrideProperties;
const AssetBundleExportJobDataSourceOverrideProperties = @import("asset_bundle_export_job_data_source_override_properties.zig").AssetBundleExportJobDataSourceOverrideProperties;
const AssetBundleExportJobFolderOverrideProperties = @import("asset_bundle_export_job_folder_override_properties.zig").AssetBundleExportJobFolderOverrideProperties;
const AssetBundleExportJobRefreshScheduleOverrideProperties = @import("asset_bundle_export_job_refresh_schedule_override_properties.zig").AssetBundleExportJobRefreshScheduleOverrideProperties;
const AssetBundleExportJobResourceIdOverrideConfiguration = @import("asset_bundle_export_job_resource_id_override_configuration.zig").AssetBundleExportJobResourceIdOverrideConfiguration;
const AssetBundleExportJobThemeOverrideProperties = @import("asset_bundle_export_job_theme_override_properties.zig").AssetBundleExportJobThemeOverrideProperties;
const AssetBundleExportJobVPCConnectionOverrideProperties = @import("asset_bundle_export_job_vpc_connection_override_properties.zig").AssetBundleExportJobVPCConnectionOverrideProperties;

/// An optional collection of CloudFormation property configurations that
/// control how
/// the export job is generated.
pub const AssetBundleCloudFormationOverridePropertyConfiguration = struct {
    /// An optional list of structures that control how `Analysis` resources are
    /// parameterized in the returned CloudFormation template.
    analyses: ?[]const AssetBundleExportJobAnalysisOverrideProperties = null,

    /// An optional list of structures that control how `Dashboard` resources are
    /// parameterized in the returned CloudFormation template.
    dashboards: ?[]const AssetBundleExportJobDashboardOverrideProperties = null,

    /// An optional list of structures that control how `DataSet` resources are
    /// parameterized in the returned CloudFormation template.
    data_sets: ?[]const AssetBundleExportJobDataSetOverrideProperties = null,

    /// An optional list of structures that control how `DataSource` resources are
    /// parameterized in the returned CloudFormation template.
    data_sources: ?[]const AssetBundleExportJobDataSourceOverrideProperties = null,

    /// An optional list of structures that controls how `Folder` resources are
    /// parameterized in the returned CloudFormation template.
    folders: ?[]const AssetBundleExportJobFolderOverrideProperties = null,

    /// An optional list of structures that control how `RefreshSchedule` resources
    /// are parameterized in the returned CloudFormation template.
    refresh_schedules: ?[]const AssetBundleExportJobRefreshScheduleOverrideProperties = null,

    /// An optional list of structures that control how resource IDs are
    /// parameterized in the
    /// returned CloudFormation template.
    resource_id_override_configuration: ?AssetBundleExportJobResourceIdOverrideConfiguration = null,

    /// An optional list of structures that control how `Theme` resources are
    /// parameterized in the returned CloudFormation template.
    themes: ?[]const AssetBundleExportJobThemeOverrideProperties = null,

    /// An optional list of structures that control how `VPCConnection` resources
    /// are
    /// parameterized in the returned CloudFormation template.
    vpc_connections: ?[]const AssetBundleExportJobVPCConnectionOverrideProperties = null,

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
