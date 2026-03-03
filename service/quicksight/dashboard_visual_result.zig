/// The QA result that is made from dashboard visual.
pub const DashboardVisualResult = struct {
    /// The ID of the dashboard.
    dashboard_id: ?[]const u8 = null,

    /// The name of the dashboard.
    dashboard_name: ?[]const u8 = null,

    /// The URL of the dashboard.
    dashboard_url: ?[]const u8 = null,

    /// The ID of the sheet.
    sheet_id: ?[]const u8 = null,

    /// The name of the sheet.
    sheet_name: ?[]const u8 = null,

    /// The ID of the visual.
    visual_id: ?[]const u8 = null,

    /// The subtitle of the visual.
    visual_subtitle: ?[]const u8 = null,

    /// The title of the visual.
    visual_title: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .dashboard_name = "DashboardName",
        .dashboard_url = "DashboardUrl",
        .sheet_id = "SheetId",
        .sheet_name = "SheetName",
        .visual_id = "VisualId",
        .visual_subtitle = "VisualSubtitle",
        .visual_title = "VisualTitle",
    };
};
