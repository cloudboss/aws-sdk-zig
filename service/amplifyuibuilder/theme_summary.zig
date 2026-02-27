/// Describes the basic information about a theme.
pub const ThemeSummary = struct {
    /// The unique ID for the app associated with the theme summary.
    app_id: []const u8,

    /// The name of the backend environment that is part of the Amplify app.
    environment_name: []const u8,

    /// The ID of the theme.
    id: []const u8,

    /// The name of the theme.
    name: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .environment_name = "environmentName",
        .id = "id",
        .name = "name",
    };
};
