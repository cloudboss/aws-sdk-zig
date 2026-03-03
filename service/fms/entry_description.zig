const NetworkAclEntry = @import("network_acl_entry.zig").NetworkAclEntry;
const EntryType = @import("entry_type.zig").EntryType;

/// Describes a single rule in a network ACL.
pub const EntryDescription = struct {
    /// Describes a rule in a network ACL.
    ///
    /// Each network ACL has a set of numbered ingress rules and a separate set of
    /// numbered egress rules. When determining
    /// whether a packet should be allowed in or out of a subnet associated with the
    /// network ACL, Amazon Web Services processes the
    /// entries in the network ACL according to the rule numbers, in ascending
    /// order.
    ///
    /// When you manage an individual network ACL, you explicitly specify the rule
    /// numbers. When you specify the network ACL rules in a Firewall Manager
    /// policy,
    /// you provide the rules to run first, in the order that you want them to run,
    /// and the rules to run last, in the order
    /// that you want them to run. Firewall Manager assigns the rule numbers for you
    /// when you save the network ACL policy specification.
    entry_detail: ?NetworkAclEntry = null,

    /// The rule number for the entry. ACL entries are processed in ascending order
    /// by rule number. In a Firewall Manager network ACL policy, Firewall Manager
    /// assigns rule numbers.
    entry_rule_number: i32 = 0,

    /// Specifies whether the entry is managed by Firewall Manager or by a user,
    /// and, for Firewall Manager-managed entries, specifies whether the entry
    /// is among those that run first in the network ACL or those that run last.
    entry_type: ?EntryType = null,

    pub const json_field_names = .{
        .entry_detail = "EntryDetail",
        .entry_rule_number = "EntryRuleNumber",
        .entry_type = "EntryType",
    };
};
