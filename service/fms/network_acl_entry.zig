const NetworkAclIcmpTypeCode = @import("network_acl_icmp_type_code.zig").NetworkAclIcmpTypeCode;
const NetworkAclPortRange = @import("network_acl_port_range.zig").NetworkAclPortRange;
const NetworkAclRuleAction = @import("network_acl_rule_action.zig").NetworkAclRuleAction;

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
pub const NetworkAclEntry = struct {
    /// The IPv4 network range to allow or deny, in CIDR notation.
    cidr_block: ?[]const u8,

    /// Indicates whether the rule is an egress, or outbound, rule (applied to
    /// traffic leaving the subnet). If it's not
    /// an egress rule, then it's an ingress, or inbound, rule.
    egress: bool,

    /// ICMP protocol: The ICMP type and code.
    icmp_type_code: ?NetworkAclIcmpTypeCode,

    /// The IPv6 network range to allow or deny, in CIDR notation.
    ipv_6_cidr_block: ?[]const u8,

    /// TCP or UDP protocols: The range of ports the rule applies to.
    port_range: ?NetworkAclPortRange,

    /// The protocol number. A value of "-1" means all protocols.
    protocol: []const u8,

    /// Indicates whether to allow or deny the traffic that matches the rule.
    rule_action: NetworkAclRuleAction,

    pub const json_field_names = .{
        .cidr_block = "CidrBlock",
        .egress = "Egress",
        .icmp_type_code = "IcmpTypeCode",
        .ipv_6_cidr_block = "Ipv6CidrBlock",
        .port_range = "PortRange",
        .protocol = "Protocol",
        .rule_action = "RuleAction",
    };
};
