const IPAddressType = @import("ip_address_type.zig").IPAddressType;

/// The ID for a subnet that's used in an association with a firewall. This is
/// used in
/// CreateFirewall, AssociateSubnets, and CreateVpcEndpointAssociation. Network
/// Firewall
/// creates an instance of the associated firewall in each subnet that you
/// specify, to filter
/// traffic in the subnet's Availability Zone.
pub const SubnetMapping = struct {
    /// The subnet's IP address type. You can't change the IP address type after you
    /// create the subnet.
    ip_address_type: ?IPAddressType,

    /// The unique identifier for the subnet.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .ip_address_type = "IPAddressType",
        .subnet_id = "SubnetId",
    };
};
