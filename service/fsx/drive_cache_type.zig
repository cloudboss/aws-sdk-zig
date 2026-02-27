pub const DriveCacheType = enum {
    none,
    read,

    pub const json_field_names = .{
        .none = "NONE",
        .read = "READ",
    };
};
