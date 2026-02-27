pub const Format = enum {
    csv,
    parquet,

    pub const json_field_names = .{
        .csv = "CSV",
        .parquet = "PARQUET",
    };
};
