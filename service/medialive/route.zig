/// Used in DescribeNetworkResult, DescribeNetworkSummary, UpdateNetworkResult.
pub const Route = struct {
    /// A CIDR block for one Route.
    cidr: ?[]const u8,

    /// The IP address of the Gateway for this route, if applicable.
    gateway: ?[]const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .gateway = "Gateway",
    };
};
