/// Dashboard summary.
pub const DashboardSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8,

    /// The time that this dashboard was created.
    created_time: ?i64,

    /// Dashboard ID.
    dashboard_id: ?[]const u8,

    /// The last time that this dashboard was published.
    last_published_time: ?i64,

    /// The last time that this dashboard was updated.
    last_updated_time: ?i64,

    /// A display name for the dashboard.
    name: ?[]const u8,

    /// Published version number.
    published_version_number: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .dashboard_id = "DashboardId",
        .last_published_time = "LastPublishedTime",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .published_version_number = "PublishedVersionNumber",
    };
};
