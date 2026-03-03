const ArcOptions = @import("arc_options.zig").ArcOptions;
const DonutCenterOptions = @import("donut_center_options.zig").DonutCenterOptions;

/// The options for configuring a donut chart or pie chart.
pub const DonutOptions = struct {
    /// The option for define the arc of the chart shape. Valid values are as
    /// follows:
    ///
    /// * `WHOLE` - A pie chart
    ///
    /// * `SMALL`- A small-sized donut chart
    ///
    /// * `MEDIUM`- A medium-sized donut chart
    ///
    /// * `LARGE`- A large-sized donut chart
    arc_options: ?ArcOptions = null,

    /// The label options of the label that is displayed in the center of a donut
    /// chart. This option isn't available for pie charts.
    donut_center_options: ?DonutCenterOptions = null,

    pub const json_field_names = .{
        .arc_options = "ArcOptions",
        .donut_center_options = "DonutCenterOptions",
    };
};
