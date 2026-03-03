const Endpoint = @import("endpoint.zig").Endpoint;

/// Represents a single node within a node group (shard).
pub const NodeGroupMember = struct {
    /// The ID of the cluster to which the node belongs.
    cache_cluster_id: ?[]const u8 = null,

    /// The ID of the node within its cluster. A node ID is a numeric identifier
    /// (0001, 0002,
    /// etc.).
    cache_node_id: ?[]const u8 = null,

    /// The role that is currently assigned to the node - `primary` or
    /// `replica`. This member is only applicable for Valkey or Redis OSS (cluster
    /// mode
    /// disabled) replication groups.
    current_role: ?[]const u8 = null,

    /// The name of the Availability Zone in which the node is located.
    preferred_availability_zone: ?[]const u8 = null,

    /// The outpost ARN of the node group member.
    preferred_outpost_arn: ?[]const u8 = null,

    /// The information required for client programs to connect to a node for read
    /// operations.
    /// The read endpoint is only applicable on Valkey or Redis OSS (cluster mode
    /// disabled) clusters.
    read_endpoint: ?Endpoint = null,
};
