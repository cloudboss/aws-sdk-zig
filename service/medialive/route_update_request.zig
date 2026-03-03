/// Used in UpdateNetworkRequest.
pub const RouteUpdateRequest = struct {
    /// A CIDR block for one Route.
    cidr: ?[]const u8 = null,

    /// The IP address of the Gateway for this route, if applicable.
    gateway: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .gateway = "Gateway",
    };
};
