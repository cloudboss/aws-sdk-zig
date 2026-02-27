pub const UplinkGbps = enum {
    uplink_1_g,
    uplink_10_g,
    uplink_40_g,
    uplink_100_g,

    pub const json_field_names = .{
        .uplink_1_g = "UPLINK_1G",
        .uplink_10_g = "UPLINK_10G",
        .uplink_40_g = "UPLINK_40G",
        .uplink_100_g = "UPLINK_100G",
    };
};
