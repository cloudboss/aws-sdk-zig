const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the `ReplaceNetworkAclAssociation` action in Amazon EC2.
/// This is a remediation option in `RemediationAction`.
pub const ReplaceNetworkAclAssociationAction = struct {
    association_id: ?ActionTarget = null,

    /// Brief description of this remediation action.
    description: ?[]const u8 = null,

    /// Indicates whether it is possible for Firewall Manager to perform this
    /// remediation action. A false value indicates that auto remediation is
    /// disabled or Firewall Manager is unable to perform the action due to a
    /// conflict of some kind.
    fms_can_remediate: bool = false,

    /// The network ACL that's associated with the remediation action.
    network_acl_id: ?ActionTarget = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .description = "Description",
        .fms_can_remediate = "FMSCanRemediate",
        .network_acl_id = "NetworkAclId",
    };
};
