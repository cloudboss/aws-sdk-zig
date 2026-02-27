/// A range of IPv4 addresses.
pub const AwsEc2SecurityGroupIpRange = struct {
    /// The IPv4 CIDR range. You can specify either a CIDR range or a source
    /// security group, but
    /// not both. To specify a single IPv4 address, use the /32 prefix length.
    cidr_ip: ?[]const u8,

    pub const json_field_names = .{
        .cidr_ip = "CidrIp",
    };
};
