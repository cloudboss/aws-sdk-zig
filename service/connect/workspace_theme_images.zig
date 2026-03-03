const ImagesLogo = @import("images_logo.zig").ImagesLogo;

/// Contains image configuration for a workspace theme.
pub const WorkspaceThemeImages = struct {
    /// The logo images used in the workspace.
    logo: ?ImagesLogo = null,

    pub const json_field_names = .{
        .logo = "Logo",
    };
};
