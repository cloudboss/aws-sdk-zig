const AwsEc2SecurityGroupIpRange = @import("aws_ec_2_security_group_ip_range.zig").AwsEc2SecurityGroupIpRange;
const AwsEc2SecurityGroupIpv6Range = @import("aws_ec_2_security_group_ipv_6_range.zig").AwsEc2SecurityGroupIpv6Range;
const AwsEc2SecurityGroupPrefixListId = @import("aws_ec_2_security_group_prefix_list_id.zig").AwsEc2SecurityGroupPrefixListId;
const AwsEc2SecurityGroupUserIdGroupPair = @import("aws_ec_2_security_group_user_id_group_pair.zig").AwsEc2SecurityGroupUserIdGroupPair;

/// An IP permission for an EC2 security group.
pub const AwsEc2SecurityGroupIpPermission = struct {
    /// The start of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6
    /// type
    /// number.
    ///
    /// A value of -1 indicates all ICMP/ICMPv6 types. If you specify all
    /// ICMP/ICMPv6 types, you
    /// must specify all codes.
    from_port: ?i32 = null,

    /// The IP protocol name (`tcp`, `udp`, `icmp`,
    /// `icmpv6`) or number.
    ///
    /// [VPC only] Use `-1` to specify all protocols.
    ///
    /// When authorizing security group rules, specifying `-1`
    /// or a protocol number other than `tcp`, `udp`, `icmp`, or
    /// `icmpv6` allows traffic on all ports, regardless of any port range you
    /// specify.
    ///
    /// For `tcp`, `udp`, and `icmp`, you must specify a port
    /// range.
    ///
    /// For `icmpv6`, the port range is optional. If you omit the port range,
    /// traffic
    /// for all types and codes is allowed.
    ip_protocol: ?[]const u8 = null,

    /// The IPv4 ranges.
    ip_ranges: ?[]const AwsEc2SecurityGroupIpRange = null,

    /// The IPv6 ranges.
    ipv_6_ranges: ?[]const AwsEc2SecurityGroupIpv6Range = null,

    /// [VPC only] The prefix list IDs for an Amazon Web Services service. With
    /// outbound rules, this is the Amazon Web Services
    /// service to access through a VPC endpoint from instances associated with the
    /// security
    /// group.
    prefix_list_ids: ?[]const AwsEc2SecurityGroupPrefixListId = null,

    /// The end of the port range for the TCP and UDP protocols, or an ICMP/ICMPv6
    /// code.
    ///
    /// A value of `-1` indicates all ICMP/ICMPv6 codes. If you specify all
    /// ICMP/ICMPv6 types, you must specify all
    /// codes.
    to_port: ?i32 = null,

    /// The security group and Amazon Web Services account ID pairs.
    user_id_group_pairs: ?[]const AwsEc2SecurityGroupUserIdGroupPair = null,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .ip_protocol = "IpProtocol",
        .ip_ranges = "IpRanges",
        .ipv_6_ranges = "Ipv6Ranges",
        .prefix_list_ids = "PrefixListIds",
        .to_port = "ToPort",
        .user_id_group_pairs = "UserIdGroupPairs",
    };
};
