/// Zookeeper node information.
pub const ZookeeperNodeInfo = struct {
    /// The attached elastic network interface of the broker.
    attached_eni_id: ?[]const u8,

    /// The virtual private cloud (VPC) IP address of the client.
    client_vpc_ip_address: ?[]const u8,

    /// Endpoints for accessing the ZooKeeper.
    endpoints: ?[]const []const u8,

    /// The role-specific ID for Zookeeper.
    zookeeper_id: ?f64,

    /// The version of Zookeeper.
    zookeeper_version: ?[]const u8,

    pub const json_field_names = .{
        .attached_eni_id = "AttachedENIId",
        .client_vpc_ip_address = "ClientVpcIpAddress",
        .endpoints = "Endpoints",
        .zookeeper_id = "ZookeeperId",
        .zookeeper_version = "ZookeeperVersion",
    };
};
