pub const IcebergTargetCompressionType = enum {
    gzip,
    lzo,
    uncompressed,
    snappy,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .lzo = "LZO",
        .uncompressed = "UNCOMPRESSED",
        .snappy = "SNAPPY",
    };
};
