/// An object that represents a virtual node service provider.
pub const VirtualRouterServiceProvider = struct {
    /// The name of the virtual router that is acting as a service provider.
    virtual_router_name: []const u8,

    pub const json_field_names = .{
        .virtual_router_name = "virtualRouterName",
    };
};
