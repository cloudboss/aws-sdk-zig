const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// theme
/// IDs.
pub const AssetBundleImportJobThemeOverridePermissions = struct {
    /// A list of permissions for the themes that you want to apply overrides to.
    permissions: AssetBundleResourcePermissions,

    /// A list of theme IDs that you want to apply overrides to. You can use `*` to
    /// override all themes in this asset bundle.
    theme_ids: []const []const u8,

    pub const json_field_names = .{
        .permissions = "Permissions",
        .theme_ids = "ThemeIds",
    };
};
