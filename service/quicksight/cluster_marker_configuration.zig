const ClusterMarker = @import("cluster_marker.zig").ClusterMarker;

/// The cluster marker configuration of the geospatial map selected point style.
pub const ClusterMarkerConfiguration = struct {
    /// The cluster marker that is a part of the cluster marker configuration.
    cluster_marker: ?ClusterMarker = null,

    pub const json_field_names = .{
        .cluster_marker = "ClusterMarker",
    };
};
