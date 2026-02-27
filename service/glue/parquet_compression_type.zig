pub const ParquetCompressionType = enum {
    snappy,
    lzo,
    gzip,
    brotli,
    lz4,
    uncompressed,
    none,

    pub const json_field_names = .{
        .snappy = "SNAPPY",
        .lzo = "LZO",
        .gzip = "GZIP",
        .brotli = "BROTLI",
        .lz4 = "LZ4",
        .uncompressed = "UNCOMPRESSED",
        .none = "NONE",
    };
};
