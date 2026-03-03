const DecalSettings = @import("decal_settings.zig").DecalSettings;
const LineChartLineStyleSettings = @import("line_chart_line_style_settings.zig").LineChartLineStyleSettings;
const LineChartMarkerStyleSettings = @import("line_chart_marker_style_settings.zig").LineChartMarkerStyleSettings;

/// The options that determine the presentation of a line series in the visual
pub const LineChartSeriesSettings = struct {
    /// Decal settings for a line series in `LineChartVisual`.
    decal_settings: ?DecalSettings = null,

    /// Line styles options for a line series in `LineChartVisual`.
    line_style_settings: ?LineChartLineStyleSettings = null,

    /// Marker styles options for a line series in `LineChartVisual`.
    marker_style_settings: ?LineChartMarkerStyleSettings = null,

    pub const json_field_names = .{
        .decal_settings = "DecalSettings",
        .line_style_settings = "LineStyleSettings",
        .marker_style_settings = "MarkerStyleSettings",
    };
};
