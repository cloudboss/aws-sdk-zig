/// The violation details for a third-party firewall for an Availability Zone
/// that's missing the Firewall Manager managed subnet.
pub const ThirdPartyFirewallMissingSubnetViolation = struct {
    /// The Availability Zone of a subnet that's causing the violation.
    availability_zone: ?[]const u8,

    /// The reason the resource is causing the violation, if a reason is available.
    target_violation_reason: ?[]const u8,

    /// The ID of the third-party firewall or VPC resource that's causing the
    /// violation.
    violation_target: ?[]const u8,

    /// The resource ID of the VPC associated with a subnet that's causing the
    /// violation.
    vpc: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .target_violation_reason = "TargetViolationReason",
        .violation_target = "ViolationTarget",
        .vpc = "VPC",
    };
};
