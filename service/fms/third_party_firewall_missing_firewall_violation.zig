/// The violation details about a third-party firewall's subnet that doesn't
/// have a Firewall Manager managed firewall in its VPC.
pub const ThirdPartyFirewallMissingFirewallViolation = struct {
    /// The Availability Zone of the third-party firewall that's causing the
    /// violation.
    availability_zone: ?[]const u8,

    /// The reason the resource is causing this violation, if a reason is available.
    target_violation_reason: ?[]const u8,

    /// The ID of the third-party firewall that's causing the violation.
    violation_target: ?[]const u8,

    /// The resource ID of the VPC associated with a third-party firewall.
    vpc: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .target_violation_reason = "TargetViolationReason",
        .violation_target = "ViolationTarget",
        .vpc = "VPC",
    };
};
