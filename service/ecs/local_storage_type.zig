pub const LocalStorageType = enum {
    hdd,
    ssd,

    pub const json_field_names = .{
        .hdd = "HDD",
        .ssd = "SSD",
    };
};
