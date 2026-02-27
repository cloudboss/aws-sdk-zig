/// Contains information about a network interface in an Amazon Redshift
/// Serverless managed VPC endpoint.
pub const NetworkInterface = struct {
    /// The availability Zone.
    availability_zone: ?[]const u8,

    /// The IPv6 address of the network interface within the subnet.
    ipv_6_address: ?[]const u8,

    /// The unique identifier of the network interface.
    network_interface_id: ?[]const u8,

    /// The IPv4 address of the network interface within the subnet.
    private_ip_address: ?[]const u8,

    /// The unique identifier of the subnet.
    subnet_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .ipv_6_address = "ipv6Address",
        .network_interface_id = "networkInterfaceId",
        .private_ip_address = "privateIpAddress",
        .subnet_id = "subnetId",
    };
};
