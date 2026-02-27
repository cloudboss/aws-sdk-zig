const VirtualNodeServiceProvider = @import("virtual_node_service_provider.zig").VirtualNodeServiceProvider;
const VirtualRouterServiceProvider = @import("virtual_router_service_provider.zig").VirtualRouterServiceProvider;

/// An object that represents the provider for a virtual service.
pub const VirtualServiceProvider = union(enum) {
    /// The virtual node associated with a virtual service.
    virtual_node: ?VirtualNodeServiceProvider,
    /// The virtual router associated with a virtual service.
    virtual_router: ?VirtualRouterServiceProvider,

    pub const json_field_names = .{
        .virtual_node = "virtualNode",
        .virtual_router = "virtualRouter",
    };
};
