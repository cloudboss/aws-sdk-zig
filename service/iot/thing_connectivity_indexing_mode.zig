pub const ThingConnectivityIndexingMode = enum {
    off,
    status,

    pub const json_field_names = .{
        .off = "OFF",
        .status = "STATUS",
    };
};
