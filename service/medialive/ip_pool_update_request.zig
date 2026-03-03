/// Used in UpdateNetworkRequest.
pub const IpPoolUpdateRequest = struct {
    /// A CIDR block of IP addresses to reserve for MediaLive Anywhere.
    cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
