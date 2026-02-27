pub const Compression = enum {
    off,
    snappy,

    pub const json_field_names = .{
        .off = "OFF",
        .snappy = "SNAPPY",
    };
};
