const BrokerSoftwareInfo = @import("broker_software_info.zig").BrokerSoftwareInfo;

/// BrokerNodeInfo
pub const BrokerNodeInfo = struct {
    /// The attached elastic network interface of the broker.
    attached_eni_id: ?[]const u8,

    /// The ID of the broker.
    broker_id: ?f64,

    /// The client subnet to which this broker node belongs.
    client_subnet: ?[]const u8,

    /// The virtual private cloud (VPC) of the client.
    client_vpc_ip_address: ?[]const u8,

    /// Information about the version of software currently deployed on the Apache
    /// Kafka brokers in the cluster.
    current_broker_software_info: ?BrokerSoftwareInfo,

    /// Endpoints for accessing the broker.
    endpoints: ?[]const []const u8,

    pub const json_field_names = .{
        .attached_eni_id = "AttachedENIId",
        .broker_id = "BrokerId",
        .client_subnet = "ClientSubnet",
        .client_vpc_ip_address = "ClientVpcIpAddress",
        .current_broker_software_info = "CurrentBrokerSoftwareInfo",
        .endpoints = "Endpoints",
    };
};
