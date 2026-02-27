/// Contains details about the firewall subnet that violates the policy scope.
pub const FirewallSubnetIsOutOfScopeViolation = struct {
    /// The ID of the firewall subnet that violates the policy scope.
    firewall_subnet_id: ?[]const u8,

    /// The Availability Zone of the firewall subnet that violates the policy scope.
    subnet_availability_zone: ?[]const u8,

    /// The Availability Zone ID of the firewall subnet that violates the policy
    /// scope.
    subnet_availability_zone_id: ?[]const u8,

    /// The VPC endpoint ID of the firewall subnet that violates the policy scope.
    vpc_endpoint_id: ?[]const u8,

    /// The VPC ID of the firewall subnet that violates the policy scope.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .firewall_subnet_id = "FirewallSubnetId",
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_availability_zone_id = "SubnetAvailabilityZoneId",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
    };
};
