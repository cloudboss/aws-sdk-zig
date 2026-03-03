/// For regional NAT gateways only: The configuration specifying which Elastic
/// IP address (EIP) to use for handling outbound NAT traffic from a specific
/// Availability Zone.
///
/// A regional NAT gateway is a single NAT Gateway that works across multiple
/// availability zones (AZs) in your VPC, providing redundancy, scalability and
/// availability across all the AZs in a Region.
///
/// For more information, see [Regional NAT gateways for automatic multi-AZ
/// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
pub const AvailabilityZoneAddress = struct {
    /// The allocation IDs of the Elastic IP addresses (EIPs) to be used for
    /// handling outbound NAT traffic in this specific Availability Zone.
    allocation_ids: ?[]const []const u8 = null,

    /// For regional NAT gateways only: The Availability Zone where this specific
    /// NAT gateway configuration will be active. Each AZ in a regional NAT gateway
    /// has its own configuration to handle outbound NAT traffic from that AZ.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    availability_zone: ?[]const u8 = null,

    /// For regional NAT gateways only: The ID of the Availability Zone where this
    /// specific NAT gateway configuration will be active. Each AZ in a regional NAT
    /// gateway has its own configuration to handle outbound NAT traffic from that
    /// AZ. Use this instead of AvailabilityZone for consistent identification of
    /// AZs across Amazon Web Services Regions.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    availability_zone_id: ?[]const u8 = null,
};
