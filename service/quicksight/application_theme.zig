const BrandColorPalette = @import("brand_color_palette.zig").BrandColorPalette;
const BrandElementStyle = @import("brand_element_style.zig").BrandElementStyle;
const ContextualAccentPalette = @import("contextual_accent_palette.zig").ContextualAccentPalette;

/// The application theme.
pub const ApplicationTheme = struct {
    /// The color palette.
    brand_color_palette: ?BrandColorPalette = null,

    /// The element style.
    brand_element_style: ?BrandElementStyle = null,

    /// The contextual accent palette.
    contextual_accent_palette: ?ContextualAccentPalette = null,

    pub const json_field_names = .{
        .brand_color_palette = "BrandColorPalette",
        .brand_element_style = "BrandElementStyle",
        .contextual_accent_palette = "ContextualAccentPalette",
    };
};
