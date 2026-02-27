pub const WirelessDeviceIdType = enum {
    wireless_device_id,
    dev_eui,
    thing_name,
    sidewalk_manufacturing_sn,

    pub const json_field_names = .{
        .wireless_device_id = "WirelessDeviceId",
        .dev_eui = "DevEui",
        .thing_name = "ThingName",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
    };
};
