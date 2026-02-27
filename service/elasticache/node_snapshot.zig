const NodeGroupConfiguration = @import("node_group_configuration.zig").NodeGroupConfiguration;

/// Represents an individual cache node in a snapshot of a cluster.
pub const NodeSnapshot = struct {
    /// A unique identifier for the source cluster.
    cache_cluster_id: ?[]const u8,

    /// The date and time when the cache node was created in the source cluster.
    cache_node_create_time: ?i64,

    /// The cache node identifier for the node in the source cluster.
    cache_node_id: ?[]const u8,

    /// The size of the cache on the source cache node.
    cache_size: ?[]const u8,

    /// The configuration for the source node group (shard).
    node_group_configuration: ?NodeGroupConfiguration,

    /// A unique identifier for the source node group (shard).
    node_group_id: ?[]const u8,

    /// The date and time when the source node's metadata and cache data set was
    /// obtained for
    /// the snapshot.
    snapshot_create_time: ?i64,
};
