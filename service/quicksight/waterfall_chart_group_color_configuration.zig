/// The color configuration for individual groups within a waterfall visual.
pub const WaterfallChartGroupColorConfiguration = struct {
    /// Defines the color for the negative bars of a waterfall chart.
    negative_bar_color: ?[]const u8 = null,

    /// Defines the color for the positive bars of a waterfall chart.
    positive_bar_color: ?[]const u8 = null,

    /// Defines the color for the total bars of a waterfall chart.
    total_bar_color: ?[]const u8 = null,

    pub const json_field_names = .{
        .negative_bar_color = "NegativeBarColor",
        .positive_bar_color = "PositiveBarColor",
        .total_bar_color = "TotalBarColor",
    };
};
