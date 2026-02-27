/// The compression used for Redshift query results.
pub const RedshiftResultCompressionType = enum {
    none,
    gzip,
    bzip2,
    zstd,
    snappy,

    pub const json_field_names = .{
        .none = "NONE",
        .gzip = "GZIP",
        .bzip2 = "BZIP2",
        .zstd = "ZSTD",
        .snappy = "SNAPPY",
    };
};
