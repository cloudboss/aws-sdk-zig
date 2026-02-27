const DataPathColor = @import("data_path_color.zig").DataPathColor;

/// The visual display options for the visual palette.
pub const VisualPalette = struct {
    /// The chart color options for the visual palette.
    chart_color: ?[]const u8,

    /// The color map options for the visual palette.
    color_map: ?[]const DataPathColor,

    pub const json_field_names = .{
        .chart_color = "ChartColor",
        .color_map = "ColorMap",
    };
};
