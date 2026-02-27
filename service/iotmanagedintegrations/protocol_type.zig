pub const ProtocolType = enum {
    zwave,
    zigbee,
    custom,

    pub const json_field_names = .{
        .zwave = "ZWAVE",
        .zigbee = "ZIGBEE",
        .custom = "CUSTOM",
    };
};
