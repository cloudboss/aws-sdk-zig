/// Specifies the file system's storage type.
pub const StorageType = enum {
    ssd,
    hdd,
    intelligent_tiering,

    pub const json_field_names = .{
        .ssd = "SSD",
        .hdd = "HDD",
        .intelligent_tiering = "INTELLIGENT_TIERING",
    };
};
