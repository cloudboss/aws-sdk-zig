pub const CompressionFormat = enum {
    uncompressed,
    gzip,
    zip,
    snappy,
    hadoop_snappy,

    pub const json_field_names = .{
        .uncompressed = "UNCOMPRESSED",
        .gzip = "GZIP",
        .zip = "ZIP",
        .snappy = "SNAPPY",
        .hadoop_snappy = "HADOOP_SNAPPY",
    };
};
