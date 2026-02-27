pub const GetDashboardRequest = struct {
    /// The name or ARN for the dashboard.
    dashboard_id: []const u8,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
    };
};
