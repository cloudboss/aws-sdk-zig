const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// data source
/// IDs.
pub const AssetBundleImportJobDataSourceOverridePermissions = struct {
    /// A list of data source IDs that you want to apply overrides to. You can use
    /// `*` to override all data sources in this asset bundle.
    data_source_ids: []const []const u8,

    /// A list of permissions for the data source that you want to apply overrides
    /// to.
    permissions: AssetBundleResourcePermissions,

    pub const json_field_names = .{
        .data_source_ids = "DataSourceIds",
        .permissions = "Permissions",
    };
};
