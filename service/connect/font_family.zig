const WorkspaceFontFamily = @import("workspace_font_family.zig").WorkspaceFontFamily;

/// Contains font family configuration for workspace themes.
pub const FontFamily = struct {
    /// The default font family to use in the workspace theme.
    default: ?WorkspaceFontFamily = null,

    pub const json_field_names = .{
        .default = "Default",
    };
};
