const NodeGroupMember = @import("node_group_member.zig").NodeGroupMember;
const Endpoint = @import("endpoint.zig").Endpoint;

/// Represents a collection of cache nodes in a replication group. One node in
/// the node
/// group is the read/write primary node. All the other nodes are read-only
/// Replica
/// nodes.
pub const NodeGroup = struct {
    /// The identifier for the node group (shard). A Valkey or Redis OSS (cluster
    /// mode disabled) replication
    /// group contains only 1 node group; therefore, the node group ID is 0001. A
    /// Valkey or Redis OSS (cluster mode enabled) replication group contains 1 to
    /// 90 node groups numbered 0001 to 0090.
    /// Optionally, the user can provide the id for a node group.
    node_group_id: ?[]const u8,

    /// A list containing information about individual nodes within the node group
    /// (shard).
    node_group_members: ?[]const NodeGroupMember,

    /// The endpoint of the primary node in this node group (shard).
    primary_endpoint: ?Endpoint,

    /// The endpoint of the replica nodes in this node group (shard). This value is
    /// read-only.
    reader_endpoint: ?Endpoint,

    /// The keyspace for this node group (shard).
    slots: ?[]const u8,

    /// The current state of this replication group - `creating`,
    /// `available`, `modifying`, `deleting`.
    status: ?[]const u8,
};
