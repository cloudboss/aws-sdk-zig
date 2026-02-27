pub const ParquetVersionValue = enum {
    parquet_1_0,
    parquet_2_0,

    pub const json_field_names = .{
        .parquet_1_0 = "PARQUET_1_0",
        .parquet_2_0 = "PARQUET_2_0",
    };
};
