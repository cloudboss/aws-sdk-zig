/// Contains a dashboard summary.
pub const DashboardSummary = struct {
    /// The date the dashboard was created, in Unix epoch time.
    creation_date: ?i64 = null,

    /// The dashboard's description.
    description: ?[]const u8 = null,

    /// The ID of the dashboard.
    id: []const u8,

    /// The date the dashboard was last updated, in Unix epoch time.
    last_update_date: ?i64 = null,

    /// The name of the dashboard
    name: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .description = "description",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
    };
};
