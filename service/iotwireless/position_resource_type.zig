pub const PositionResourceType = enum {
    wireless_device,
    wireless_gateway,

    pub const json_field_names = .{
        .wireless_device = "WirelessDevice",
        .wireless_gateway = "WirelessGateway",
    };
};
