const BorderSettings = @import("border_settings.zig").BorderSettings;
const DecalSettings = @import("decal_settings.zig").DecalSettings;
const LineChartLineStyleSettings = @import("line_chart_line_style_settings.zig").LineChartLineStyleSettings;
const LineChartMarkerStyleSettings = @import("line_chart_marker_style_settings.zig").LineChartMarkerStyleSettings;

/// Options that determine the presentation of a series in the visual.
pub const ComboChartSeriesSettings = struct {
    /// Border settings for the bar series in the visual.
    border_settings: ?BorderSettings = null,

    /// Decal settings for the series in the visual.
    decal_settings: ?DecalSettings = null,

    /// Line styles options for the line series in the visual.
    line_style_settings: ?LineChartLineStyleSettings = null,

    /// Marker styles options for the line series in the visual.
    marker_style_settings: ?LineChartMarkerStyleSettings = null,

    pub const json_field_names = .{
        .border_settings = "BorderSettings",
        .decal_settings = "DecalSettings",
        .line_style_settings = "LineStyleSettings",
        .marker_style_settings = "MarkerStyleSettings",
    };
};
