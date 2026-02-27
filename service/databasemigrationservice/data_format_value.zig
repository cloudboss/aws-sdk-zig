pub const DataFormatValue = enum {
    csv,
    parquet,

    pub const json_field_names = .{
        .csv = "CSV",
        .parquet = "PARQUET",
    };
};
