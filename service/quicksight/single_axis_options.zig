const YAxisOptions = @import("y_axis_options.zig").YAxisOptions;

/// The settings of a chart's single axis configuration.
pub const SingleAxisOptions = struct {
    /// The Y axis options of a single axis configuration.
    y_axis_options: ?YAxisOptions = null,

    pub const json_field_names = .{
        .y_axis_options = "YAxisOptions",
    };
};
