const WaterfallChartGroupColorConfiguration = @import("waterfall_chart_group_color_configuration.zig").WaterfallChartGroupColorConfiguration;

/// The color configuration of a waterfall visual.
pub const WaterfallChartColorConfiguration = struct {
    /// The color configuration for individual groups within a waterfall visual.
    group_color_configuration: ?WaterfallChartGroupColorConfiguration,

    pub const json_field_names = .{
        .group_color_configuration = "GroupColorConfiguration",
    };
};
