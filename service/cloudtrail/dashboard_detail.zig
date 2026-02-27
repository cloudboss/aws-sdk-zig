const DashboardType = @import("dashboard_type.zig").DashboardType;

/// Provides information about a CloudTrail Lake dashboard.
pub const DashboardDetail = struct {
    /// The ARN for the dashboard.
    dashboard_arn: ?[]const u8,

    /// The type of dashboard.
    @"type": ?DashboardType,

    pub const json_field_names = .{
        .dashboard_arn = "DashboardArn",
        .@"type" = "Type",
    };
};
