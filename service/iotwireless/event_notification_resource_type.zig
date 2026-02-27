pub const EventNotificationResourceType = enum {
    sidewalk_account,
    wireless_device,
    wireless_gateway,

    pub const json_field_names = .{
        .sidewalk_account = "SidewalkAccount",
        .wireless_device = "WirelessDevice",
        .wireless_gateway = "WirelessGateway",
    };
};
