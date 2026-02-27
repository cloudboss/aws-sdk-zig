pub const DimensionName = enum {
    device_id,
    gateway_id,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .gateway_id = "GatewayId",
    };
};
