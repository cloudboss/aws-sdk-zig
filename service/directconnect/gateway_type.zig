pub const GatewayType = enum {
    virtual_private_gateway,
    transit_gateway,

    pub const json_field_names = .{
        .virtual_private_gateway = "VirtualPrivateGateway",
        .transit_gateway = "TransitGateway",
    };
};
