/// The compression used for Athena query results.
pub const AthenaResultCompressionType = enum {
    gzip,
    snappy,
    zlib,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .snappy = "SNAPPY",
        .zlib = "ZLIB",
    };
};
