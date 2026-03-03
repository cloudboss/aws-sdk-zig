const SimpleClusterMarker = @import("simple_cluster_marker.zig").SimpleClusterMarker;

/// The cluster marker that is a part of the cluster marker
/// configuration.
pub const ClusterMarker = struct {
    /// The simple cluster marker of the cluster marker.
    simple_cluster_marker: ?SimpleClusterMarker = null,

    pub const json_field_names = .{
        .simple_cluster_marker = "SimpleClusterMarker",
    };
};
