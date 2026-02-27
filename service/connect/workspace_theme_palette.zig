const PaletteCanvas = @import("palette_canvas.zig").PaletteCanvas;
const PaletteHeader = @import("palette_header.zig").PaletteHeader;
const PaletteNavigation = @import("palette_navigation.zig").PaletteNavigation;
const PalettePrimary = @import("palette_primary.zig").PalettePrimary;

/// Contains color palette configuration for different areas of a workspace.
pub const WorkspaceThemePalette = struct {
    /// The color configuration for the canvas area.
    canvas: ?PaletteCanvas,

    /// The color configuration for the header area.
    header: ?PaletteHeader,

    /// The color configuration for the navigation area.
    navigation: ?PaletteNavigation,

    /// The primary color configuration used throughout the workspace.
    primary: ?PalettePrimary,

    pub const json_field_names = .{
        .canvas = "Canvas",
        .header = "Header",
        .navigation = "Navigation",
        .primary = "Primary",
    };
};
