const IcmpTypeCode = @import("icmp_type_code.zig").IcmpTypeCode;
const PortRange = @import("port_range.zig").PortRange;
const RuleAction = @import("rule_action.zig").RuleAction;

/// Describes an entry in a network ACL.
pub const NetworkAclEntry = struct {
    /// The IPv4 network range to allow or deny, in CIDR notation.
    cidr_block: ?[]const u8 = null,

    /// Indicates whether the rule is an egress rule (applied to traffic leaving the
    /// subnet).
    egress: ?bool = null,

    /// ICMP protocol: The ICMP type and code.
    icmp_type_code: ?IcmpTypeCode = null,

    /// The IPv6 network range to allow or deny, in CIDR notation.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// TCP or UDP protocols: The range of ports the rule applies to.
    port_range: ?PortRange = null,

    /// The protocol number. A value of "-1" means all protocols.
    protocol: ?[]const u8 = null,

    /// Indicates whether to allow or deny the traffic that matches the rule.
    rule_action: ?RuleAction = null,

    /// The rule number for the entry. ACL entries are processed in ascending order
    /// by rule number.
    rule_number: ?i32 = null,
};
