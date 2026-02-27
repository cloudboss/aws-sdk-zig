/// A rule that allows a specific CIDR block to access the public router network
/// interface.
pub const PublicRouterNetworkInterfaceRule = struct {
    /// The CIDR block that is allowed to access the public router network
    /// interface.
    cidr: []const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
