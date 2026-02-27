pub const WirelessDeviceSidewalkStatus = enum {
    provisioned,
    registered,
    activated,
    unknown,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .registered = "REGISTERED",
        .activated = "ACTIVATED",
        .unknown = "UNKNOWN",
    };
};
