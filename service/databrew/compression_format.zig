pub const CompressionFormat = enum {
    gzip,
    lz4,
    snappy,
    bzip2,
    deflate,
    lzo,
    brotli,
    zstd,
    zlib,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .lz4 = "LZ4",
        .snappy = "SNAPPY",
        .bzip2 = "BZIP2",
        .deflate = "DEFLATE",
        .lzo = "LZO",
        .brotli = "BROTLI",
        .zstd = "ZSTD",
        .zlib = "ZLIB",
    };
};
