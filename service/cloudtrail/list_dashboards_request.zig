const DashboardType = @import("dashboard_type.zig").DashboardType;

pub const ListDashboardsRequest = struct {
    /// The maximum number of dashboards to display on a single page.
    max_results: ?i32,

    /// Specify a name prefix to filter on.
    name_prefix: ?[]const u8,

    /// A token you can use to get the next page of dashboard results.
    next_token: ?[]const u8,

    /// Specify a dashboard type to filter on: `CUSTOM` or `MANAGED`.
    @"type": ?DashboardType,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
        .@"type" = "Type",
    };
};
