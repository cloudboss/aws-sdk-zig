const WorkspaceThemeConfig = @import("workspace_theme_config.zig").WorkspaceThemeConfig;

/// Contains theme configuration for a workspace, supporting both light and dark
/// modes.
pub const WorkspaceTheme = struct {
    /// The theme configuration for dark mode.
    dark: ?WorkspaceThemeConfig,

    /// The theme configuration for light mode.
    light: ?WorkspaceThemeConfig,

    pub const json_field_names = .{
        .dark = "Dark",
        .light = "Light",
    };
};
