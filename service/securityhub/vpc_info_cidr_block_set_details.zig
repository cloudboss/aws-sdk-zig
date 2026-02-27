/// Provides details about the IPv4 CIDR blocks for the VPC.
pub const VpcInfoCidrBlockSetDetails = struct {
    /// The IPv4 CIDR block for the VPC.
    cidr_block: ?[]const u8,

    pub const json_field_names = .{
        .cidr_block = "CidrBlock",
    };
};
