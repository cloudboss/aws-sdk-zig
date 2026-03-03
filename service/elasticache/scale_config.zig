/// Configuration settings for horizontal or vertical scaling operations on
/// Memcached clusters.
pub const ScaleConfig = struct {
    /// The time interval in seconds between scaling operations when performing
    /// gradual scaling for a Memcached cluster.
    scale_interval_minutes: ?i32 = null,

    /// The percentage by which to scale the Memcached cluster, either horizontally
    /// by adding nodes or vertically by increasing resources.
    scale_percentage: ?i32 = null,
};
