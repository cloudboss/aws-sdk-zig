const IcmpTypeCode = @import("icmp_type_code.zig").IcmpTypeCode;
const PortRangeFromTo = @import("port_range_from_to.zig").PortRangeFromTo;

/// A rule for the network ACL. Each rule allows or denies access based on the
/// IP address, traffic direction, port, and protocol.
pub const AwsEc2NetworkAclEntry = struct {
    /// The IPV4 network range for which to deny or allow access.
    cidr_block: ?[]const u8 = null,

    /// Whether the rule is an egress rule. An egress rule is a rule that applies to
    /// traffic that leaves the subnet.
    egress: ?bool = null,

    /// The Internet Control Message Protocol (ICMP) type and code for which to deny
    /// or allow access.
    icmp_type_code: ?IcmpTypeCode = null,

    /// The IPV6 network range for which to deny or allow access.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// For TCP or UDP protocols, the range of ports that the rule applies to.
    port_range: ?PortRangeFromTo = null,

    /// The protocol that the rule applies to. To deny or allow access to all
    /// protocols, use the
    /// value `-1`.
    protocol: ?[]const u8 = null,

    /// Whether the rule is used to allow access or deny access.
    rule_action: ?[]const u8 = null,

    /// The rule number. The rules are processed in order by their number.
    rule_number: ?i32 = null,

    pub const json_field_names = .{
        .cidr_block = "CidrBlock",
        .egress = "Egress",
        .icmp_type_code = "IcmpTypeCode",
        .ipv_6_cidr_block = "Ipv6CidrBlock",
        .port_range = "PortRange",
        .protocol = "Protocol",
        .rule_action = "RuleAction",
        .rule_number = "RuleNumber",
    };
};
