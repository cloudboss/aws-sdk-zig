pub const CompressionMethod = enum {
    none,
    gzip,

    pub const json_field_names = .{
        .none = "NONE",
        .gzip = "GZIP",
    };
};
