const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;

/// The sort configuration of a scatter plot.
pub const ScatterPlotSortConfiguration = struct {
    scatter_plot_limit_configuration: ?ItemsLimitConfiguration,

    pub const json_field_names = .{
        .scatter_plot_limit_configuration = "ScatterPlotLimitConfiguration",
    };
};
