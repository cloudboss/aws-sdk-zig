/// A range of IPv6 addresses.
pub const AwsEc2SecurityGroupIpv6Range = struct {
    /// The IPv6 CIDR range. You can specify either a CIDR range or a source
    /// security group, but
    /// not both. To specify a single IPv6 address, use the /128 prefix length.
    cidr_ipv_6: ?[]const u8,

    pub const json_field_names = .{
        .cidr_ipv_6 = "CidrIpv6",
    };
};
