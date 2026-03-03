/// Prefixes of the subnet IP.
pub const SubnetIpPrefixes = struct {
    /// Array of SubnetIpPrefixes objects.
    ip_prefixes: ?[]const []const u8 = null,

    /// ID of the subnet.
    subnet_id: ?[]const u8 = null,
};
