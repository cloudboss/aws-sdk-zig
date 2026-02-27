pub const CompressionOption = enum {
    gzip,
    parquet,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .parquet = "PARQUET",
    };
};
