const WorkspaceThemeImages = @import("workspace_theme_images.zig").WorkspaceThemeImages;
const WorkspaceThemePalette = @import("workspace_theme_palette.zig").WorkspaceThemePalette;
const WorkspaceThemeTypography = @import("workspace_theme_typography.zig").WorkspaceThemeTypography;

/// Contains detailed theme configuration for a workspace, including colors,
/// images, and typography.
pub const WorkspaceThemeConfig = struct {
    /// The image assets used in the workspace theme.
    images: ?WorkspaceThemeImages = null,

    /// The color palette configuration for the workspace theme.
    palette: ?WorkspaceThemePalette = null,

    /// The typography configuration for the workspace theme.
    typography: ?WorkspaceThemeTypography = null,

    pub const json_field_names = .{
        .images = "Images",
        .palette = "Palette",
        .typography = "Typography",
    };
};
