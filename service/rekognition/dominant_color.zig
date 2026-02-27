/// A description of the dominant colors in an image.
pub const DominantColor = struct {
    /// The Blue RGB value for a dominant color.
    blue: ?i32,

    /// The CSS color name of a dominant color.
    css_color: ?[]const u8,

    /// The Green RGB value for a dominant color.
    green: ?i32,

    /// The Hex code equivalent of the RGB values for a dominant color.
    hex_code: ?[]const u8,

    /// The percentage of image pixels that have a given dominant color.
    pixel_percent: ?f32,

    /// The Red RGB value for a dominant color.
    red: ?i32,

    /// One of 12 simplified color names applied to a dominant color.
    simplified_color: ?[]const u8,

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
