pub const DiscoveryType = enum {
    zwave,
    zigbee,
    cloud,
    custom,
    controller_capability_rediscovery,

    pub const json_field_names = .{
        .zwave = "ZWAVE",
        .zigbee = "ZIGBEE",
        .cloud = "CLOUD",
        .custom = "CUSTOM",
        .controller_capability_rediscovery = "CONTROLLER_CAPABILITY_REDISCOVERY",
    };
};
