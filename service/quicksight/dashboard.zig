const DashboardVersion = @import("dashboard_version.zig").DashboardVersion;

/// Dashboard.
pub const Dashboard = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The time that this dashboard was created.
    created_time: ?i64 = null,

    /// Dashboard ID.
    dashboard_id: ?[]const u8 = null,

    /// The last time that this dashboard was published.
    last_published_time: ?i64 = null,

    /// The last time that this dashboard was updated.
    last_updated_time: ?i64 = null,

    /// A list of analysis Amazon Resource Names (ARNs) to be linked to the
    /// dashboard.
    link_entities: ?[]const []const u8 = null,

    /// A display name for the dashboard.
    name: ?[]const u8 = null,

    /// Version.
    version: ?DashboardVersion = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .dashboard_id = "DashboardId",
        .last_published_time = "LastPublishedTime",
        .last_updated_time = "LastUpdatedTime",
        .link_entities = "LinkEntities",
        .name = "Name",
        .version = "Version",
    };
};
