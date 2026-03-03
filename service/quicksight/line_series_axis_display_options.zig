const AxisDisplayOptions = @import("axis_display_options.zig").AxisDisplayOptions;
const MissingDataConfiguration = @import("missing_data_configuration.zig").MissingDataConfiguration;

/// The series axis configuration of a line chart.
pub const LineSeriesAxisDisplayOptions = struct {
    /// The options that determine the presentation of the line series axis.
    axis_options: ?AxisDisplayOptions = null,

    /// The configuration options that determine how missing data is treated during
    /// the rendering of a line chart.
    missing_data_configurations: ?[]const MissingDataConfiguration = null,

    pub const json_field_names = .{
        .axis_options = "AxisOptions",
        .missing_data_configurations = "MissingDataConfigurations",
    };
};
