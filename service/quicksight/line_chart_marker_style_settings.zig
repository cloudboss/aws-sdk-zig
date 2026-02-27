const LineChartMarkerShape = @import("line_chart_marker_shape.zig").LineChartMarkerShape;
const Visibility = @import("visibility.zig").Visibility;

/// Marker styles options for a line series in `LineChartVisual`.
pub const LineChartMarkerStyleSettings = struct {
    /// Color of marker in the series.
    marker_color: ?[]const u8,

    /// Shape option for markers in the series.
    ///
    /// * `CIRCLE`: Show marker as a circle.
    ///
    /// * `TRIANGLE`: Show marker as a triangle.
    ///
    /// * `SQUARE`: Show marker as a square.
    ///
    /// * `DIAMOND`: Show marker as a diamond.
    ///
    /// * `ROUNDED_SQUARE`: Show marker as a rounded square.
    marker_shape: ?LineChartMarkerShape,

    /// Size of marker in the series.
    marker_size: ?[]const u8,

    /// Configuration option that determines whether to show the markers in the
    /// series.
    marker_visibility: ?Visibility,

    pub const json_field_names = .{
        .marker_color = "MarkerColor",
        .marker_shape = "MarkerShape",
        .marker_size = "MarkerSize",
        .marker_visibility = "MarkerVisibility",
    };
};
