const IpRange = @import("ip_range.zig").IpRange;
const Ipv6Range = @import("ipv_6_range.zig").Ipv6Range;
const PrefixListId = @import("prefix_list_id.zig").PrefixListId;
const UserIdGroupPair = @import("user_id_group_pair.zig").UserIdGroupPair;

/// Describes the permissions for a security group rule.
pub const IpPermission = struct {
    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP type or -1 (all ICMP
    /// types).
    from_port: ?i32,

    /// The IP protocol name (`tcp`, `udp`, `icmp`, `icmpv6`)
    /// or number (see [Protocol
    /// Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)).
    ///
    /// Use `-1` to specify all protocols. When authorizing
    /// security group rules, specifying `-1` or a protocol number other than
    /// `tcp`, `udp`, `icmp`, or `icmpv6` allows
    /// traffic on all ports, regardless of any port range you specify. For `tcp`,
    /// `udp`, and `icmp`, you must specify a port range. For `icmpv6`,
    /// the port range is optional; if you omit the port range, traffic for all
    /// types and codes is allowed.
    ip_protocol: ?[]const u8,

    /// The IPv4 address ranges.
    ip_ranges: ?[]const IpRange,

    /// The IPv6 address ranges.
    ipv_6_ranges: ?[]const Ipv6Range,

    /// The prefix list IDs.
    prefix_list_ids: ?[]const PrefixListId,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP code or -1 (all ICMP
    /// codes).
    /// If the start port is -1 (all ICMP types), then the end port must be -1 (all
    /// ICMP codes).
    to_port: ?i32,

    /// The security group and Amazon Web Services account ID pairs.
    user_id_group_pairs: ?[]const UserIdGroupPair,
};
