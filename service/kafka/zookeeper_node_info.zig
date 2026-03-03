/// Zookeeper node information.
pub const ZookeeperNodeInfo = struct {
    /// The attached elastic network interface of the broker.
    attached_eni_id: ?[]const u8 = null,

    /// The virtual private cloud (VPC) IP address of the client.
    client_vpc_ip_address: ?[]const u8 = null,

    /// Endpoints for accessing the ZooKeeper.
    endpoints: ?[]const []const u8 = null,

    /// The role-specific ID for Zookeeper.
    zookeeper_id: ?f64 = null,

    /// The version of Zookeeper.
    zookeeper_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_eni_id = "AttachedENIId",
        .client_vpc_ip_address = "ClientVpcIpAddress",
        .endpoints = "Endpoints",
        .zookeeper_id = "ZookeeperId",
        .zookeeper_version = "ZookeeperVersion",
    };
};
