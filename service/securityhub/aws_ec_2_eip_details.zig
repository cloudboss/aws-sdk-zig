/// Information about an Elastic IP address.
pub const AwsEc2EipDetails = struct {
    /// The identifier that Amazon Web Services assigns to represent the allocation
    /// of the Elastic IP address
    /// for use with Amazon VPC.
    allocation_id: ?[]const u8,

    /// The identifier that represents the association of the Elastic IP address
    /// with an EC2
    /// instance.
    association_id: ?[]const u8,

    /// The domain in which to allocate the address.
    ///
    /// If the address is for use with EC2 instances in a VPC, then `Domain` is
    /// `vpc`. Otherwise, `Domain` is `standard`.
    domain: ?[]const u8,

    /// The identifier of the EC2 instance.
    instance_id: ?[]const u8,

    /// The name of the location from which the Elastic IP address is advertised.
    network_border_group: ?[]const u8,

    /// The identifier of the network interface.
    network_interface_id: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the network interface.
    network_interface_owner_id: ?[]const u8,

    /// The private IP address that is associated with the Elastic IP address.
    private_ip_address: ?[]const u8,

    /// A public IP address that is associated with the EC2 instance.
    public_ip: ?[]const u8,

    /// The identifier of an IP address pool. This parameter allows Amazon EC2 to
    /// select an IP
    /// address from the address pool.
    public_ipv_4_pool: ?[]const u8,

    pub const json_field_names = .{
        .allocation_id = "AllocationId",
        .association_id = "AssociationId",
        .domain = "Domain",
        .instance_id = "InstanceId",
        .network_border_group = "NetworkBorderGroup",
        .network_interface_id = "NetworkInterfaceId",
        .network_interface_owner_id = "NetworkInterfaceOwnerId",
        .private_ip_address = "PrivateIpAddress",
        .public_ip = "PublicIp",
        .public_ipv_4_pool = "PublicIpv4Pool",
    };
};
