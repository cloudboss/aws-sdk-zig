/// IP range information for an RDS DB security group.
pub const AwsRdsDbSecurityGroupIpRange = struct {
    /// Specifies the IP range.
    cidr_ip: ?[]const u8 = null,

    /// Specifies the status of the IP range.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr_ip = "CidrIp",
        .status = "Status",
    };
};
