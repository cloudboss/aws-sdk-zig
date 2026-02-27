/// Describes a set of permissions for a security group rule.
pub const SecurityGroupRuleDescription = struct {
    /// The start of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6
    /// type number. A value of `-1` indicates all ICMP/ICMPv6 types.
    from_port: ?i64,

    /// The IPv4 ranges for the security group rule.
    ipv4_range: ?[]const u8,

    /// The IPv6 ranges for the security group rule.
    ipv6_range: ?[]const u8,

    /// The ID of the prefix list for the security group rule.
    prefix_list_id: ?[]const u8,

    /// The IP protocol name (`tcp`, `udp`, `icmp`, `icmpv6`) or number.
    protocol: ?[]const u8,

    /// The end of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6
    /// code. A value of `-1` indicates all ICMP/ICMPv6 codes.
    to_port: ?i64,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .ipv4_range = "IPV4Range",
        .ipv6_range = "IPV6Range",
        .prefix_list_id = "PrefixListId",
        .protocol = "Protocol",
        .to_port = "ToPort",
    };
};
