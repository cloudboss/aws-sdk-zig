/// A network route configuration.
pub const InputDestinationRoute = struct {
    /// The CIDR of the route.
    cidr: ?[]const u8 = null,

    /// An optional gateway for the route.
    gateway: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .gateway = "Gateway",
    };
};
