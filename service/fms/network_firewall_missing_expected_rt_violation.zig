/// Violation detail for Network Firewall for a subnet that's not associated to
/// the expected
/// Firewall Manager managed route table.
pub const NetworkFirewallMissingExpectedRTViolation = struct {
    /// The Availability Zone of a violating subnet.
    availability_zone: ?[]const u8,

    /// The resource ID of the current route table that's associated with the
    /// subnet, if one is available.
    current_route_table: ?[]const u8,

    /// The resource ID of the route table that should be associated with the
    /// subnet.
    expected_route_table: ?[]const u8,

    /// The ID of the Network Firewall or VPC resource that's in violation.
    violation_target: ?[]const u8,

    /// The resource ID of the VPC associated with a violating subnet.
    vpc: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .current_route_table = "CurrentRouteTable",
        .expected_route_table = "ExpectedRouteTable",
        .violation_target = "ViolationTarget",
        .vpc = "VPC",
    };
};
