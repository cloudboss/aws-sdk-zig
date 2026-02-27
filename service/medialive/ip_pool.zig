/// Used in DescribeNetworkResult, DescribeNetworkSummary, UpdateNetworkResult.
pub const IpPool = struct {
    /// A CIDR block of IP addresses that are reserved for MediaLive Anywhere.
    cidr: ?[]const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
