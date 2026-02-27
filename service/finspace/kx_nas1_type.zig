pub const KxNAS1Type = enum {
    ssd_1000,
    ssd_250,
    hdd_12,

    pub const json_field_names = .{
        .ssd_1000 = "SSD_1000",
        .ssd_250 = "SSD_250",
        .hdd_12 = "HDD_12",
    };
};
