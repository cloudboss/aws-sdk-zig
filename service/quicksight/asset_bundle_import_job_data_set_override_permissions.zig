const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// dataset
/// IDs.
pub const AssetBundleImportJobDataSetOverridePermissions = struct {
    /// A list of dataset IDs that you want to apply overrides to. You can use `*`
    /// to
    /// override all datasets in this asset bundle.
    data_set_ids: []const []const u8,

    /// A list of permissions for the datasets that you want to apply overrides to.
    permissions: AssetBundleResourcePermissions,

    pub const json_field_names = .{
        .data_set_ids = "DataSetIds",
        .permissions = "Permissions",
    };
};
