/// A node in an Amazon Redshift cluster.
pub const AwsRedshiftClusterClusterNode = struct {
    /// The role of the node. A node might be a leader node or a compute node.
    node_role: ?[]const u8 = null,

    /// The private IP address of the node.
    private_ip_address: ?[]const u8 = null,

    /// The public IP address of the node.
    public_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .node_role = "NodeRole",
        .private_ip_address = "PrivateIpAddress",
        .public_ip_address = "PublicIpAddress",
    };
};
