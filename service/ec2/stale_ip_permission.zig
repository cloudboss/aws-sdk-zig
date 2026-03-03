const UserIdGroupPair = @import("user_id_group_pair.zig").UserIdGroupPair;

/// Describes a stale rule in a security group.
pub const StaleIpPermission = struct {
    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP type or -1 (all ICMP
    /// types).
    from_port: ?i32 = null,

    /// The IP protocol name (`tcp`, `udp`, `icmp`, `icmpv6`) or number
    /// (see [Protocol
    /// Numbers)](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    ip_protocol: ?[]const u8 = null,

    /// The IP ranges. Not applicable for stale security group rules.
    ip_ranges: ?[]const []const u8 = null,

    /// The prefix list IDs. Not applicable for stale security group rules.
    prefix_list_ids: ?[]const []const u8 = null,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP or ICMPv6, this is the ICMP code or -1 (all ICMP
    /// codes).
    to_port: ?i32 = null,

    /// The security group pairs. Returns the ID of the referenced security group
    /// and VPC, and the ID and status of the VPC peering connection.
    user_id_group_pairs: ?[]const UserIdGroupPair = null,
};
