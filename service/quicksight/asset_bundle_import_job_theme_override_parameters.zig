/// The override parameters for a single theme that is imported.
pub const AssetBundleImportJobThemeOverrideParameters = struct {
    /// A new name for the theme.
    name: ?[]const u8 = null,

    /// The ID of the theme to apply overrides to.
    theme_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .theme_id = "ThemeId",
    };
};
