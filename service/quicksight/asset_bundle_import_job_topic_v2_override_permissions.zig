const AssetBundleResourcePermissions = @import("asset_bundle_resource_permissions.zig").AssetBundleResourcePermissions;

/// An object that contains a list of permissions to be applied to a list of
/// topic
/// IDs.
pub const AssetBundleImportJobTopicV2OverridePermissions = struct {
    /// A list of permissions for the topics that you want to apply overrides to.
    permissions: AssetBundleResourcePermissions,

    /// A list of topic IDs that you want to apply overrides to. You can use `*` to
    /// override all topics in this asset bundle.
    topic_ids: []const []const u8,

    pub const json_field_names = .{
        .permissions = "Permissions",
        .topic_ids = "TopicIds",
    };
};
