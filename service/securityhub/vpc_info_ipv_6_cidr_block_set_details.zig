/// Provides details about the IPv6 CIDR blocks for the VPC.
pub const VpcInfoIpv6CidrBlockSetDetails = struct {
    /// The IPv6 CIDR block for the VPC.
    ipv_6_cidr_block: ?[]const u8,

    pub const json_field_names = .{
        .ipv_6_cidr_block = "Ipv6CidrBlock",
    };
};
