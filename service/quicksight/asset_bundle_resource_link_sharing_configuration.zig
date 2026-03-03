const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// A structure that contains the configuration of a shared link to an Amazon
/// Quick Sight
/// dashboard.
pub const AssetBundleResourceLinkSharingConfiguration = struct {
    /// A list of link sharing permissions for the dashboards that you want to apply
    /// overrides
    /// to.
    permissions: ?AssetBundleResourcePermissions = null,

    pub const json_field_names = .{
        .permissions = "Permissions",
    };
};
