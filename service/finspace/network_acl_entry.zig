const IcmpTypeCode = @import("icmp_type_code.zig").IcmpTypeCode;
const PortRange = @import("port_range.zig").PortRange;
const RuleAction = @import("rule_action.zig").RuleAction;

/// The network access control list (ACL) is an optional layer of security for
/// your VPC that acts as a firewall for controlling traffic in and out of one
/// or more subnets. The entry is a set of numbered ingress and egress rules
/// that determine whether a packet should be allowed in or out of a subnet
/// associated with the ACL. We process the entries in the ACL according to the
/// rule numbers, in ascending order.
pub const NetworkACLEntry = struct {
    /// The IPv4 network range to allow or deny, in CIDR notation. For example,
    /// `172.16.0.0/24`. We modify the specified CIDR block to its canonical form.
    /// For example, if you specify `100.68.0.18/18`, we modify it to
    /// `100.68.0.0/18`.
    cidr_block: []const u8,

    /// Defines the ICMP protocol that consists of the ICMP type and code.
    icmp_type_code: ?IcmpTypeCode = null,

    /// The range of ports the rule applies to.
    port_range: ?PortRange = null,

    /// The protocol number. A value of *-1* means all the protocols.
    protocol: []const u8,

    /// Indicates whether to allow or deny the traffic that matches the rule.
    rule_action: RuleAction,

    /// The rule number for the entry. For example *100*. All the network ACL
    /// entries are processed in ascending order by rule number.
    rule_number: i32,

    pub const json_field_names = .{
        .cidr_block = "cidrBlock",
        .icmp_type_code = "icmpTypeCode",
        .port_range = "portRange",
        .protocol = "protocol",
        .rule_action = "ruleAction",
        .rule_number = "ruleNumber",
    };
};
