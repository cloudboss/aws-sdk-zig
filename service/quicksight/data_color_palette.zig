/// The theme colors that are used for data colors in charts. The colors
/// description is a
/// hexadecimal color code that consists of six alphanumerical characters,
/// prefixed with
/// `#`, for example #37BFF5.
pub const DataColorPalette = struct {
    /// The hexadecimal codes for the colors.
    colors: ?[]const []const u8 = null,

    /// The hexadecimal code of a color that applies to charts where a lack of data
    /// is
    /// highlighted.
    empty_fill_color: ?[]const u8 = null,

    /// The minimum and maximum hexadecimal codes that describe a color gradient.
    min_max_gradient: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .colors = "Colors",
        .empty_fill_color = "EmptyFillColor",
        .min_max_gradient = "MinMaxGradient",
    };
};
