/// A network route configuration.
pub const InputRequestDestinationRoute = struct {
    /// The CIDR of the route.
    cidr: ?[]const u8,

    /// An optional gateway for the route.
    gateway: ?[]const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .gateway = "Gateway",
    };
};
