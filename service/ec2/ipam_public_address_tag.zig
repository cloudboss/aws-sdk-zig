/// A tag for a public IP address discovered by IPAM.
pub const IpamPublicAddressTag = struct {
    /// The tag's key.
    key: ?[]const u8 = null,

    /// The tag's value.
    value: ?[]const u8 = null,
};
