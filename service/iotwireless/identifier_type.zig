pub const IdentifierType = enum {
    partner_account_id,
    dev_eui,
    gateway_eui,
    wireless_device_id,
    wireless_gateway_id,

    pub const json_field_names = .{
        .partner_account_id = "PartnerAccountId",
        .dev_eui = "DevEui",
        .gateway_eui = "GatewayEui",
        .wireless_device_id = "WirelessDeviceId",
        .wireless_gateway_id = "WirelessGatewayId",
    };
};
