const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// analysis
/// IDs.
pub const AssetBundleImportJobAnalysisOverridePermissions = struct {
    /// A list of analysis IDs that you want to apply overrides to. You can use `*`
    /// to override all analyses in this asset bundle.
    analysis_ids: []const []const u8,

    /// A list of permissions for the analyses that you want to apply overrides to.
    permissions: AssetBundleResourcePermissions,

    pub const json_field_names = .{
        .analysis_ids = "AnalysisIds",
        .permissions = "Permissions",
    };
};
