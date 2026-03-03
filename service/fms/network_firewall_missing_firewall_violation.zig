/// Violation detail for Network Firewall for a subnet that doesn't have a
/// Firewall Manager managed firewall in its VPC.
pub const NetworkFirewallMissingFirewallViolation = struct {
    /// The Availability Zone of a violating subnet.
    availability_zone: ?[]const u8 = null,

    /// The reason the resource has this violation, if one is available.
    target_violation_reason: ?[]const u8 = null,

    /// The ID of the Network Firewall or VPC resource that's in violation.
    violation_target: ?[]const u8 = null,

    /// The resource ID of the VPC associated with a violating subnet.
    vpc: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .target_violation_reason = "TargetViolationReason",
        .violation_target = "ViolationTarget",
        .vpc = "VPC",
    };
};
