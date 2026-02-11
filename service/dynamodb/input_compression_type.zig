pub const InputCompressionType = enum {
    gzip,
    zstd,
    none,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .zstd = "ZSTD",
        .none = "NONE",
    };
};
