const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// folder
/// IDs.
pub const AssetBundleImportJobFolderOverridePermissions = struct {
    /// A list of folder IDs that you want to apply overrides to. You can use `*` to
    /// override all folders in this asset bundle.
    folder_ids: []const []const u8,

    permissions: ?AssetBundleResourcePermissions = null,

    pub const json_field_names = .{
        .folder_ids = "FolderIds",
        .permissions = "Permissions",
    };
};
