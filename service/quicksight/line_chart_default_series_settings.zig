const AxisBinding = @import("axis_binding.zig").AxisBinding;
const DecalSettings = @import("decal_settings.zig").DecalSettings;
const LineChartLineStyleSettings = @import("line_chart_line_style_settings.zig").LineChartLineStyleSettings;
const LineChartMarkerStyleSettings = @import("line_chart_marker_style_settings.zig").LineChartMarkerStyleSettings;

/// The options that determine the default presentation of all line series in
/// `LineChartVisual`.
pub const LineChartDefaultSeriesSettings = struct {
    /// The axis to which you are binding all line series to.
    axis_binding: ?AxisBinding,

    /// Decal settings options for all line series in the visual.
    decal_settings: ?DecalSettings,

    /// Line styles options for all line series in the visual.
    line_style_settings: ?LineChartLineStyleSettings,

    /// Marker styles options for all line series in the visual.
    marker_style_settings: ?LineChartMarkerStyleSettings,

    pub const json_field_names = .{
        .axis_binding = "AxisBinding",
        .decal_settings = "DecalSettings",
        .line_style_settings = "LineStyleSettings",
        .marker_style_settings = "MarkerStyleSettings",
    };
};
