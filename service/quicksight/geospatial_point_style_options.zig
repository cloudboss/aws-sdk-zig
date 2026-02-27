const ClusterMarkerConfiguration = @import("cluster_marker_configuration.zig").ClusterMarkerConfiguration;
const GeospatialHeatmapConfiguration = @import("geospatial_heatmap_configuration.zig").GeospatialHeatmapConfiguration;
const GeospatialSelectedPointStyle = @import("geospatial_selected_point_style.zig").GeospatialSelectedPointStyle;

/// The point style of the geospatial map.
pub const GeospatialPointStyleOptions = struct {
    /// The cluster marker configuration of the geospatial point style.
    cluster_marker_configuration: ?ClusterMarkerConfiguration,

    /// The heatmap configuration of the geospatial point style.
    heatmap_configuration: ?GeospatialHeatmapConfiguration,

    /// The selected point styles (point, cluster) of the geospatial map.
    selected_point_style: ?GeospatialSelectedPointStyle,

    pub const json_field_names = .{
        .cluster_marker_configuration = "ClusterMarkerConfiguration",
        .heatmap_configuration = "HeatmapConfiguration",
        .selected_point_style = "SelectedPointStyle",
    };
};
