const AssetBundleImportJobAnalysisOverrideTags = @import("asset_bundle_import_job_analysis_override_tags.zig").AssetBundleImportJobAnalysisOverrideTags;
const AssetBundleImportJobDashboardOverrideTags = @import("asset_bundle_import_job_dashboard_override_tags.zig").AssetBundleImportJobDashboardOverrideTags;
const AssetBundleImportJobDataSetOverrideTags = @import("asset_bundle_import_job_data_set_override_tags.zig").AssetBundleImportJobDataSetOverrideTags;
const AssetBundleImportJobDataSourceOverrideTags = @import("asset_bundle_import_job_data_source_override_tags.zig").AssetBundleImportJobDataSourceOverrideTags;
const AssetBundleImportJobFolderOverrideTags = @import("asset_bundle_import_job_folder_override_tags.zig").AssetBundleImportJobFolderOverrideTags;
const AssetBundleImportJobThemeOverrideTags = @import("asset_bundle_import_job_theme_override_tags.zig").AssetBundleImportJobThemeOverrideTags;
const AssetBundleImportJobVPCConnectionOverrideTags = @import("asset_bundle_import_job_vpc_connection_override_tags.zig").AssetBundleImportJobVPCConnectionOverrideTags;

/// A structure that contains the override tag configuration that modify the
/// tags that are
/// assigned to specified resources before the resource is imported.
pub const AssetBundleImportJobOverrideTags = struct {
    /// A list of tag overrides for any `Analysis` resources that are present in the
    /// asset bundle that is imported.
    analyses: ?[]const AssetBundleImportJobAnalysisOverrideTags,

    /// A list of tag overrides for any `Dashboard` resources that are present in
    /// the
    /// asset bundle that is imported.
    dashboards: ?[]const AssetBundleImportJobDashboardOverrideTags,

    /// A list of tag overrides for any `DataSet` resources that are present in the
    /// asset bundle that is imported.
    data_sets: ?[]const AssetBundleImportJobDataSetOverrideTags,

    /// A list of tag overrides for any `DataSource` resources that are present in
    /// the asset bundle that is imported.
    data_sources: ?[]const AssetBundleImportJobDataSourceOverrideTags,

    /// A list of tag overrides for any `Folder` resources that are present in the
    /// asset bundle that is imported.
    folders: ?[]const AssetBundleImportJobFolderOverrideTags,

    /// A list of tag overrides for any `Theme` resources that are present in the
    /// asset bundle that is imported.
    themes: ?[]const AssetBundleImportJobThemeOverrideTags,

    /// A list of tag overrides for any `VPCConnection` resources that are present
    /// in
    /// the asset bundle that is imported.
    vpc_connections: ?[]const AssetBundleImportJobVPCConnectionOverrideTags,

    pub const json_field_names = .{
        .analyses = "Analyses",
        .dashboards = "Dashboards",
        .data_sets = "DataSets",
        .data_sources = "DataSources",
        .folders = "Folders",
        .themes = "Themes",
        .vpc_connections = "VPCConnections",
    };
};
