/// Represents a specific dashboard.
pub const DashboardEntry = struct {
    /// The Amazon Resource Name (ARN) of the dashboard.
    dashboard_arn: ?[]const u8,

    /// The name of the dashboard.
    dashboard_name: ?[]const u8,

    /// The time stamp of when the dashboard was last modified, either by an API
    /// call or
    /// through the console. This number is expressed as the number of milliseconds
    /// since Jan 1,
    /// 1970 00:00:00 UTC.
    last_modified: ?i64,

    /// The size of the dashboard, in bytes.
    size: ?i64,

    pub const json_field_names = .{
        .dashboard_arn = "DashboardArn",
        .dashboard_name = "DashboardName",
        .last_modified = "LastModified",
        .size = "Size",
    };
};
