/// The violation details for a third-party firewall that's not associated with
/// an Firewall Manager managed route table.
pub const ThirdPartyFirewallMissingExpectedRouteTableViolation = struct {
    /// The Availability Zone of the firewall subnet that's causing the violation.
    availability_zone: ?[]const u8 = null,

    /// The resource ID of the current route table that's associated with the
    /// subnet, if one is available.
    current_route_table: ?[]const u8 = null,

    /// The resource ID of the route table that should be associated with the
    /// subnet.
    expected_route_table: ?[]const u8 = null,

    /// The ID of the third-party firewall or VPC resource that's causing the
    /// violation.
    violation_target: ?[]const u8 = null,

    /// The resource ID of the VPC associated with a fireawll subnet that's causing
    /// the violation.
    vpc: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .current_route_table = "CurrentRouteTable",
        .expected_route_table = "ExpectedRouteTable",
        .violation_target = "ViolationTarget",
        .vpc = "VPC",
    };
};
