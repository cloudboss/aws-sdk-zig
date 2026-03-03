/// Dashboard summary.
pub const DashboardSummary = struct {
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

    /// A display name for the dashboard.
    name: ?[]const u8 = null,

    /// Published version number.
    published_version_number: ?i64 = null,

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
