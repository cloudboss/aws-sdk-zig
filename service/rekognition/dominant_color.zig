/// A description of the dominant colors in an image.
pub const DominantColor = struct {
    /// The Blue RGB value for a dominant color.
    blue: ?i32 = null,

    /// The CSS color name of a dominant color.
    css_color: ?[]const u8 = null,

    /// The Green RGB value for a dominant color.
    green: ?i32 = null,

    /// The Hex code equivalent of the RGB values for a dominant color.
    hex_code: ?[]const u8 = null,

    /// The percentage of image pixels that have a given dominant color.
    pixel_percent: ?f32 = null,

    /// The Red RGB value for a dominant color.
    red: ?i32 = null,

    /// One of 12 simplified color names applied to a dominant color.
    simplified_color: ?[]const u8 = null,

    pub const json_field_names = .{
        .blue = "Blue",
        .css_color = "CSSColor",
        .green = "Green",
        .hex_code = "HexCode",
        .pixel_percent = "PixelPercent",
        .red = "Red",
        .simplified_color = "SimplifiedColor",
    };
};
