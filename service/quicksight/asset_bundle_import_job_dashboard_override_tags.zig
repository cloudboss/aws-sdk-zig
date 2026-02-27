const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of dashboard
/// IDs.
pub const AssetBundleImportJobDashboardOverrideTags = struct {
    /// A list of dashboard IDs that you want to apply overrides to. You can use `*`
    /// to override all dashboards in this asset bundle.
    dashboard_ids: []const []const u8,

    /// A list of tags for the dashboards that you want to apply overrides to.
    tags: []const Tag,

    pub const json_field_names = .{
        .dashboard_ids = "DashboardIds",
        .tags = "Tags",
    };
};
