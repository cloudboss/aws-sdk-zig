const LineInterpolation = @import("line_interpolation.zig").LineInterpolation;
const LineChartLineStyle = @import("line_chart_line_style.zig").LineChartLineStyle;
const Visibility = @import("visibility.zig").Visibility;

/// Line styles options for a line series in `LineChartVisual`.
pub const LineChartLineStyleSettings = struct {
    /// Interpolation style for line series.
    ///
    /// * `LINEAR`: Show as default, linear style.
    ///
    /// * `SMOOTH`: Show as a smooth curve.
    ///
    /// * `STEPPED`: Show steps in line.
    line_interpolation: ?LineInterpolation,

    /// Line style for line series.
    ///
    /// * `SOLID`: Show as a solid line.
    ///
    /// * `DOTTED`: Show as a dotted line.
    ///
    /// * `DASHED`: Show as a dashed line.
    line_style: ?LineChartLineStyle,

    /// Configuration option that determines whether to show the line for the
    /// series.
    line_visibility: ?Visibility,

    /// Width that determines the line thickness.
    line_width: ?[]const u8,

    pub const json_field_names = .{
        .line_interpolation = "LineInterpolation",
        .line_style = "LineStyle",
        .line_visibility = "LineVisibility",
        .line_width = "LineWidth",
    };
};
