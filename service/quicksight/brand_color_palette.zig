const Palette = @import("palette.zig").Palette;

/// The color palette.
pub const BrandColorPalette = struct {
    /// The color that is used for accent elements.
    accent: ?Palette = null,

    /// The color that is used for danger elements.
    danger: ?Palette = null,

    /// The color that is used for dimension elements.
    dimension: ?Palette = null,

    /// The color that is used for info elements.
    info: ?Palette = null,

    /// The color that is used for measure elements.
    measure: ?Palette = null,

    /// The primary color.
    primary: ?Palette = null,

    /// The secondary color.
    secondary: ?Palette = null,

    /// The color that is used for success elements.
    success: ?Palette = null,

    /// The color that is used for warning elements.
    warning: ?Palette = null,

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
