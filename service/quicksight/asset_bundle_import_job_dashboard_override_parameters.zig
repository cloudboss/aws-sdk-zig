/// The override parameters for a single dashboard that is being imported.
pub const AssetBundleImportJobDashboardOverrideParameters = struct {
    /// The ID of the dashboard that you want to apply overrides to.
    dashboard_id: []const u8,

    /// A new name for the dashboard.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .name = "Name",
    };
};
