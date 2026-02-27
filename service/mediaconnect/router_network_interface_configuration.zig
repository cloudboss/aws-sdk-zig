const PublicRouterNetworkInterfaceConfiguration = @import("public_router_network_interface_configuration.zig").PublicRouterNetworkInterfaceConfiguration;
const VpcRouterNetworkInterfaceConfiguration = @import("vpc_router_network_interface_configuration.zig").VpcRouterNetworkInterfaceConfiguration;

/// The configuration settings for a router network interface.
pub const RouterNetworkInterfaceConfiguration = union(enum) {
    public: ?PublicRouterNetworkInterfaceConfiguration,
    vpc: ?VpcRouterNetworkInterfaceConfiguration,

    pub const json_field_names = .{
        .public = "Public",
        .vpc = "Vpc",
    };
};
