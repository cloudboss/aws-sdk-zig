pub const WirelessGatewayIdType = enum {
    gateway_eui,
    wireless_gateway_id,
    thing_name,

    pub const json_field_names = .{
        .gateway_eui = "GatewayEui",
        .wireless_gateway_id = "WirelessGatewayId",
        .thing_name = "ThingName",
    };
};
