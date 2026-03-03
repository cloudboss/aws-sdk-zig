const AssetBundleResourceLinkSharingConfiguration = @import("asset_bundle_resource_link_sharing_configuration.zig").AssetBundleResourceLinkSharingConfiguration;
const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// dashboard
/// IDs.
pub const AssetBundleImportJobDashboardOverridePermissions = struct {
    /// A list of dashboard IDs that you want to apply overrides to. You can use `*`
    /// to override all dashboards in this asset bundle.
    dashboard_ids: []const []const u8,

    /// A structure that contains the link sharing configurations that you want to
    /// apply
    /// overrides to.
    link_sharing_configuration: ?AssetBundleResourceLinkSharingConfiguration = null,

    /// A list of permissions for the dashboards that you want to apply overrides
    /// to.
    permissions: ?AssetBundleResourcePermissions = null,

    pub const json_field_names = .{
        .dashboard_ids = "DashboardIds",
        .link_sharing_configuration = "LinkSharingConfiguration",
        .permissions = "Permissions",
    };
};
