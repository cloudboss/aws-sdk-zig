/// Describes a security group rule.
///
/// You must specify exactly one of the following parameters, based on the rule
/// type:
///
/// * CidrIpv4
///
/// * CidrIpv6
///
/// * PrefixListId
///
/// * ReferencedGroupId
///
/// Amazon Web Services
/// [canonicalizes](https://en.wikipedia.org/wiki/Canonicalization) IPv4 and
/// IPv6 CIDRs. For example, if you specify 100.68.0.18/18 for the CIDR block,
/// Amazon Web Services canonicalizes the CIDR block to 100.68.0.0/18. Any
/// subsequent DescribeSecurityGroups and DescribeSecurityGroupRules calls will
/// return the canonicalized form of the CIDR block. Additionally, if you
/// attempt to add another rule with the
/// non-canonical form of the CIDR (such as 100.68.0.18/18) and there is already
/// a rule for the canonicalized
/// form of the CIDR block (such as 100.68.0.0/18), the API throws an duplicate
/// rule error.
///
/// When you modify a rule, you cannot change the rule type. For example, if the
/// rule
/// uses an IPv4 address range, you must use `CidrIpv4` to specify a new IPv4
/// address range.
pub const SecurityGroupRuleRequest = struct {
    /// The IPv4 CIDR range. To specify a single IPv4 address, use the /32 prefix
    /// length.
    cidr_ipv_4: ?[]const u8,

    /// The IPv6 CIDR range. To specify a single IPv6 address, use the /128 prefix
    /// length.
    cidr_ipv_6: ?[]const u8,

    /// The description of the security group rule.
    description: ?[]const u8,

    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP type or -1 (all ICMP
    /// types).
    from_port: ?i32,

    /// The IP protocol name (`tcp`, `udp`, `icmp`,
    /// `icmpv6`) or number (see [Protocol
    /// Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)).
    ///
    /// Use `-1` to specify all protocols.
    ip_protocol: ?[]const u8,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8,

    /// The ID of the security group that is referenced in the security group rule.
    referenced_group_id: ?[]const u8,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP code or -1 (all ICMP
    /// codes).
    /// If the start port is -1 (all ICMP types), then the end port must be -1 (all
    /// ICMP codes).
    to_port: ?i32,
};
