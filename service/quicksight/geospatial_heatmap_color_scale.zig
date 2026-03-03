const GeospatialHeatmapDataColor = @import("geospatial_heatmap_data_color.zig").GeospatialHeatmapDataColor;

/// The color scale specification for the heatmap point style.
pub const GeospatialHeatmapColorScale = struct {
    /// The list of colors to be used in heatmap point style.
    colors: ?[]const GeospatialHeatmapDataColor = null,

    pub const json_field_names = .{
        .colors = "Colors",
    };
};
