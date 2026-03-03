const Node = @import("node.zig").Node;

/// Represents a collection of nodes in a cluster. One node in the node group is
/// the read/write primary node. All the other nodes are read-only Replica
/// nodes.
pub const Shard = struct {
    /// The name of the shard
    name: ?[]const u8 = null,

    /// A list containing information about individual nodes within the shard
    nodes: ?[]const Node = null,

    /// The number of nodes in the shard
    number_of_nodes: ?i32 = null,

    /// The keyspace for this shard.
    slots: ?[]const u8 = null,

    /// The current state of this replication group - creating, available,
    /// modifying, deleting.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .nodes = "Nodes",
        .number_of_nodes = "NumberOfNodes",
        .slots = "Slots",
        .status = "Status",
    };
};
