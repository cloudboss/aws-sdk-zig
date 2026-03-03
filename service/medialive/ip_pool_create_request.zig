/// Used in CreateNetworkRequest.
pub const IpPoolCreateRequest = struct {
    /// A CIDR block of IP addresses to reserve for MediaLive Anywhere.
    cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
