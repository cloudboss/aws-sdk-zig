/// The violation details for a firewall subnet's VPC endpoint that's deleted or
/// missing.
pub const FirewallSubnetMissingVPCEndpointViolation = struct {
    /// The ID of the firewall that this VPC endpoint is associated with.
    firewall_subnet_id: ?[]const u8,

    /// The name of the Availability Zone of the deleted VPC subnet.
    subnet_availability_zone: ?[]const u8,

    /// The ID of the Availability Zone of the deleted VPC subnet.
    subnet_availability_zone_id: ?[]const u8,

    /// The resource ID of the VPC associated with the deleted VPC subnet.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .firewall_subnet_id = "FirewallSubnetId",
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_availability_zone_id = "SubnetAvailabilityZoneId",
        .vpc_id = "VpcId",
    };
};
