const EntryDescription = @import("entry_description.zig").EntryDescription;
const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the `DeleteNetworkAclEntries` action in Amazon EC2. This
/// is a remediation option in `RemediationAction`.
pub const DeleteNetworkAclEntriesAction = struct {
    /// Brief description of this remediation action.
    description: ?[]const u8,

    /// Indicates whether it is possible for Firewall Manager to perform this
    /// remediation action. A false value indicates that auto remediation is
    /// disabled or Firewall Manager is unable to perform the action due to a
    /// conflict of some kind.
    fms_can_remediate: bool = false,

    /// Lists the entries that the remediation action would delete.
    network_acl_entries_to_be_deleted: ?[]const EntryDescription,

    /// The network ACL that's associated with the remediation action.
    network_acl_id: ?ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .fms_can_remediate = "FMSCanRemediate",
        .network_acl_entries_to_be_deleted = "NetworkAclEntriesToBeDeleted",
        .network_acl_id = "NetworkAclId",
    };
};
