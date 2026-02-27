/// The identifier of a node in a cluster.
pub const ClusterNode = struct {
    /// Whether the node is a leader node or a compute node.
    node_role: ?[]const u8,

    /// The private IP address of a node within a cluster.
    private_ip_address: ?[]const u8,

    /// The public IP address of a node within a cluster.
    public_ip_address: ?[]const u8,
};
