const FontFamily = @import("font_family.zig").FontFamily;

/// Contains typography configuration for a workspace theme.
pub const WorkspaceThemeTypography = struct {
    /// The font family configuration for text in the workspace.
    font_family: ?FontFamily,

    pub const json_field_names = .{
        .font_family = "FontFamily",
    };
};
