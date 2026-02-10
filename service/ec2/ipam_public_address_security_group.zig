/// The security group that the resource with the public IP address is in.
pub const IpamPublicAddressSecurityGroup = struct {
    /// The security group's ID.
    group_id: ?[]const u8,

    /// The security group's name.
    group_name: ?[]const u8,
};
