const Palette = @import("palette.zig").Palette;

/// The color palette.
pub const BrandColorPalette = struct {
    /// The color that is used for accent elements.
    accent: ?Palette,

    /// The color that is used for danger elements.
    danger: ?Palette,

    /// The color that is used for dimension elements.
    dimension: ?Palette,

    /// The color that is used for info elements.
    info: ?Palette,

    /// The color that is used for measure elements.
    measure: ?Palette,

    /// The primary color.
    primary: ?Palette,

    /// The secondary color.
    secondary: ?Palette,

    /// The color that is used for success elements.
    success: ?Palette,

    /// The color that is used for warning elements.
    warning: ?Palette,

    pub const json_field_names = .{
        .accent = "Accent",
        .danger = "Danger",
        .dimension = "Dimension",
        .info = "Info",
        .measure = "Measure",
        .primary = "Primary",
        .secondary = "Secondary",
        .success = "Success",
        .warning = "Warning",
    };
};
