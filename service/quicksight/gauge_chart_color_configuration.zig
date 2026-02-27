/// The color configuration of a `GaugeChartVisual`.
pub const GaugeChartColorConfiguration = struct {
    /// The background color configuration of a `GaugeChartVisual`.
    background_color: ?[]const u8,

    /// The foreground color configuration of a `GaugeChartVisual`.
    foreground_color: ?[]const u8,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .foreground_color = "ForegroundColor",
    };
};
