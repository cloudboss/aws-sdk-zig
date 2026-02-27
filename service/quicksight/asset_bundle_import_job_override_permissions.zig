const AssetBundleImportJobAnalysisOverridePermissions = @import("asset_bundle_import_job_analysis_override_permissions.zig").AssetBundleImportJobAnalysisOverridePermissions;
const AssetBundleImportJobDashboardOverridePermissions = @import("asset_bundle_import_job_dashboard_override_permissions.zig").AssetBundleImportJobDashboardOverridePermissions;
const AssetBundleImportJobDataSetOverridePermissions = @import("asset_bundle_import_job_data_set_override_permissions.zig").AssetBundleImportJobDataSetOverridePermissions;
const AssetBundleImportJobDataSourceOverridePermissions = @import("asset_bundle_import_job_data_source_override_permissions.zig").AssetBundleImportJobDataSourceOverridePermissions;
const AssetBundleImportJobFolderOverridePermissions = @import("asset_bundle_import_job_folder_override_permissions.zig").AssetBundleImportJobFolderOverridePermissions;
const AssetBundleImportJobThemeOverridePermissions = @import("asset_bundle_import_job_theme_override_permissions.zig").AssetBundleImportJobThemeOverridePermissions;

/// A structure that contains the override permission configurations that modify
/// the
/// permissions for specified resources before the resource is imported.
pub const AssetBundleImportJobOverridePermissions = struct {
    /// A list of permissions overrides for any `Analysis` resources that are
    /// present
    /// in the asset bundle that is imported.
    analyses: ?[]const AssetBundleImportJobAnalysisOverridePermissions,

    /// A list of permissions overrides for any `Dashboard` resources that are
    /// present in the asset bundle that is imported.
    dashboards: ?[]const AssetBundleImportJobDashboardOverridePermissions,

    /// A list of permissions overrides for any `DataSet` resources that are present
    /// in the asset bundle that is imported.
    data_sets: ?[]const AssetBundleImportJobDataSetOverridePermissions,

    /// A list of permissions overrides for any `DataSource` resources that are
    /// present in the asset bundle that is imported.
    data_sources: ?[]const AssetBundleImportJobDataSourceOverridePermissions,

    /// A list of permissions for the folders that you want to apply overrides to.
    folders: ?[]const AssetBundleImportJobFolderOverridePermissions,

    /// A list of permissions overrides for any `Theme` resources that are present
    /// in
    /// the asset bundle that is imported.
    themes: ?[]const AssetBundleImportJobThemeOverridePermissions,

    pub const json_field_names = .{
        .analyses = "Analyses",
        .dashboards = "Dashboards",
        .data_sets = "DataSets",
        .data_sources = "DataSources",
        .folders = "Folders",
        .themes = "Themes",
    };
};
