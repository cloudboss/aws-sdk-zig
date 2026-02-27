/// The compression format that Amazon Web Services uses for the report.
pub const CompressionFormat = enum {
    zip,
    gzip,
    parquet,

    pub const json_field_names = .{
        .zip = "ZIP",
        .gzip = "GZIP",
        .parquet = "Parquet",
    };
};
