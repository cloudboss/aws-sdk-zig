pub const DevicePoolType = enum {
    curated,
    private,

    pub const json_field_names = .{
        .curated = "CURATED",
        .private = "PRIVATE",
    };
};
