const GeospatialHeatmapColorScale = @import("geospatial_heatmap_color_scale.zig").GeospatialHeatmapColorScale;

/// The heatmap configuration of the geospatial point style.
pub const GeospatialHeatmapConfiguration = struct {
    /// The color scale specification for the heatmap point style.
    heatmap_color: ?GeospatialHeatmapColorScale = null,

    pub const json_field_names = .{
        .heatmap_color = "HeatmapColor",
    };
};
