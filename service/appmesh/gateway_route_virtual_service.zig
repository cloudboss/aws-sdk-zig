/// An object that represents the virtual service that traffic is routed to.
pub const GatewayRouteVirtualService = struct {
    /// The name of the virtual service that traffic is routed to.
    virtual_service_name: []const u8,

    pub const json_field_names = .{
        .virtual_service_name = "virtualServiceName",
    };
};
