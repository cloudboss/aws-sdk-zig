/// A structure that contains the following elements:
///
/// * The `DashboardId` of the dashboard that has the visual that you
/// want to embed.
///
/// * The `SheetId` of the sheet that has the visual that you want to
/// embed.
///
/// * The `VisualId` of the visual that you want to embed.
///
/// The `DashboardId`, `SheetId`, and `VisualId` can be
/// found in the `IDs for developers` section of the `Embed visual`
/// pane of the visual's on-visual menu of the Amazon Quick Sight console. You
/// can also get
/// the `DashboardId` with a `ListDashboards` API operation.
pub const DashboardVisualId = struct {
    /// The ID of the dashboard that has the visual that you want to embed. The
    /// `DashboardId` can be found in the `IDs for developers` section
    /// of the `Embed visual` pane of the visual's on-visual menu of the Quick
    /// console. You can also get the `DashboardId` with a
    /// `ListDashboards` API operation.
    dashboard_id: []const u8,

    /// The ID of the sheet that the has visual that you want to embed. The
    /// `SheetId` can be found in the `IDs for developers` section of
    /// the `Embed visual` pane of the visual's on-visual menu of the Quick console.
    sheet_id: []const u8,

    /// The ID of the visual that you want to embed. The `VisualID` can be found in
    /// the `IDs for developers` section of the `Embed visual` pane of the
    /// visual's on-visual menu of the Amazon Quick Sight console.
    visual_id: []const u8,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .sheet_id = "SheetId",
        .visual_id = "VisualId",
    };
};
