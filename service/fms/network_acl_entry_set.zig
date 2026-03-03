const NetworkAclEntry = @import("network_acl_entry.zig").NetworkAclEntry;

/// The configuration of the first and last rules for the network ACL policy,
/// and the remediation settings for each.
pub const NetworkAclEntrySet = struct {
    /// The rules that you want to run first in the Firewall Manager managed network
    /// ACLs.
    ///
    /// Provide these in the order in which you want them to run. Firewall Manager
    /// will assign
    /// the specific rule numbers for you, in the network ACLs that it creates.
    ///
    /// You must specify at least one first entry or one last entry in any network
    /// ACL policy.
    first_entries: ?[]const NetworkAclEntry = null,

    /// Applies only when remediation is enabled for the policy as a whole. Firewall
    /// Manager uses this setting when it finds policy
    /// violations that involve conflicts between the custom entries and the policy
    /// entries.
    ///
    /// If forced remediation is disabled, Firewall Manager marks the network ACL as
    /// noncompliant and does not try to
    /// remediate. For more information about the remediation behavior, see
    /// [Remediation for managed network
    /// ACLs](https://docs.aws.amazon.com/waf/latest/developerguide/network-acl-policies.html#network-acls-remediation)
    /// in the *Firewall Manager Developer Guide*.
    force_remediate_for_first_entries: bool,

    /// Applies only when remediation is enabled for the policy as a whole. Firewall
    /// Manager uses this setting when it finds policy
    /// violations that involve conflicts between the custom entries and the policy
    /// entries.
    ///
    /// If forced remediation is disabled, Firewall Manager marks the network ACL as
    /// noncompliant and does not try to
    /// remediate. For more information about the remediation behavior, see
    /// [Remediation for managed network
    /// ACLs](https://docs.aws.amazon.com/waf/latest/developerguide/network-acl-policies.html#network-acls-remediation)
    /// in the *Firewall Manager Developer Guide*.
    force_remediate_for_last_entries: bool,

    /// The rules that you want to run last in the Firewall Manager managed network
    /// ACLs.
    ///
    /// Provide these in the order in which you want them to run. Firewall Manager
    /// will assign
    /// the specific rule numbers for you, in the network ACLs that it creates.
    ///
    /// You must specify at least one first entry or one last entry in any network
    /// ACL policy.
    last_entries: ?[]const NetworkAclEntry = null,

    pub const json_field_names = .{
        .first_entries = "FirstEntries",
        .force_remediate_for_first_entries = "ForceRemediateForFirstEntries",
        .force_remediate_for_last_entries = "ForceRemediateForLastEntries",
        .last_entries = "LastEntries",
    };
};
