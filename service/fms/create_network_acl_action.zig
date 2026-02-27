const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the `CreateNetworkAcl` action in Amazon EC2. This is a
/// remediation option in `RemediationAction`.
pub const CreateNetworkAclAction = struct {
    /// Brief description of this remediation action.
    description: ?[]const u8,

    /// Indicates whether it is possible for Firewall Manager to perform this
    /// remediation action. A false value indicates that auto remediation is
    /// disabled or Firewall Manager is unable to perform the action due to a
    /// conflict of some kind.
    fms_can_remediate: bool = false,

    /// The VPC that's associated with the remediation action.
    vpc: ?ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .fms_can_remediate = "FMSCanRemediate",
        .vpc = "Vpc",
    };
};
