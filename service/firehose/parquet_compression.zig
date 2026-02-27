pub const ParquetCompression = enum {
    uncompressed,
    gzip,
    snappy,

    pub const json_field_names = .{
        .uncompressed = "UNCOMPRESSED",
        .gzip = "GZIP",
        .snappy = "SNAPPY",
    };
};
