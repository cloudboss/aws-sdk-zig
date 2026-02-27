/// The type of compression to use producing records to the target cluster.
pub const TargetCompressionType = enum {
    none,
    gzip,
    snappy,
    lz4,
    zstd,

    pub const json_field_names = .{
        .none = "NONE",
        .gzip = "GZIP",
        .snappy = "SNAPPY",
        .lz4 = "LZ4",
        .zstd = "ZSTD",
    };
};
