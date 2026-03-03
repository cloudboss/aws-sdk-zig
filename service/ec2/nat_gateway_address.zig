const NatGatewayAddressStatus = @import("nat_gateway_address_status.zig").NatGatewayAddressStatus;

/// Describes the IP addresses and network interface associated with a NAT
/// gateway.
pub const NatGatewayAddress = struct {
    /// [Public NAT gateway only] The allocation ID of the Elastic IP address that's
    /// associated with the NAT gateway.
    allocation_id: ?[]const u8 = null,

    /// [Public NAT gateway only] The association ID of the Elastic IP address
    /// that's associated with the NAT gateway.
    association_id: ?[]const u8 = null,

    /// The Availability Zone where this Elastic IP address (EIP) is being used to
    /// handle outbound NAT traffic.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone where this Elastic IP address (EIP) is being
    /// used to handle outbound NAT traffic. Use this instead of AvailabilityZone
    /// for consistent identification of AZs across Amazon Web Services Regions.
    availability_zone_id: ?[]const u8 = null,

    /// The address failure message.
    failure_message: ?[]const u8 = null,

    /// Defines if the IP address is the primary address.
    is_primary: ?bool = null,

    /// The ID of the network interface associated with the NAT gateway.
    network_interface_id: ?[]const u8 = null,

    /// The private IP address associated with the NAT gateway.
    private_ip: ?[]const u8 = null,

    /// [Public NAT gateway only] The Elastic IP address associated with the NAT
    /// gateway.
    public_ip: ?[]const u8 = null,

    /// The address status.
    status: ?NatGatewayAddressStatus = null,
};
