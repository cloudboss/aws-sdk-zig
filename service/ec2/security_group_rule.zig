const ReferencedSecurityGroup = @import("referenced_security_group.zig").ReferencedSecurityGroup;
const Tag = @import("tag.zig").Tag;

/// Describes a security group rule.
pub const SecurityGroupRule = struct {
    /// The IPv4 CIDR range.
    cidr_ipv_4: ?[]const u8 = null,

    /// The IPv6 CIDR range.
    cidr_ipv_6: ?[]const u8 = null,

    /// The security group rule description.
    description: ?[]const u8 = null,

    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP type or -1 (all ICMP
    /// types).
    from_port: ?i32 = null,

    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the security group.
    group_owner_id: ?[]const u8 = null,

    /// The IP protocol name (`tcp`, `udp`, `icmp`,
    /// `icmpv6`) or number (see [Protocol
    /// Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)).
    ///
    /// Use `-1` to specify all protocols.
    ip_protocol: ?[]const u8 = null,

    /// Indicates whether the security group rule is an outbound rule.
    is_egress: ?bool = null,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8 = null,

    /// Describes the security group that is referenced in the rule.
    referenced_group_info: ?ReferencedSecurityGroup = null,

    /// The ARN of the security group rule.
    security_group_rule_arn: ?[]const u8 = null,

    /// The ID of the security group rule.
    security_group_rule_id: ?[]const u8 = null,

    /// The tags applied to the security group rule.
    tags: ?[]const Tag = null,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP code or -1 (all ICMP
    /// codes).
    /// If the start port is -1 (all ICMP types), then the end port must be -1 (all
    /// ICMP codes).
    to_port: ?i32 = null,
};
