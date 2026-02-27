pub const OpenZFSDataCompressionType = enum {
    none,
    zstd,
    lz4,

    pub const json_field_names = .{
        .none = "NONE",
        .zstd = "ZSTD",
        .lz4 = "LZ4",
    };
};
