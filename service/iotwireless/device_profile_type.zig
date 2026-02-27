pub const DeviceProfileType = enum {
    sidewalk,
    lo_ra_wan,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
        .lo_ra_wan = "LoRaWAN",
    };
};
