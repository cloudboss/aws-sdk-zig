/// The security group that the resource with the public IP address is in.
pub const IpamPublicAddressSecurityGroup = struct {
    /// The security group's ID.
    group_id: ?[]const u8 = null,

    /// The security group's name.
    group_name: ?[]const u8 = null,
};
