const DashboardDetail = @import("dashboard_detail.zig").DashboardDetail;

pub const ListDashboardsResponse = struct {
    /// Contains information about dashboards in the account, in the current Region
    /// that match the applied filters.
    dashboards: ?[]const DashboardDetail,

    /// A token you can use to get the next page of dashboard results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .dashboards = "Dashboards",
        .next_token = "NextToken",
    };
};
