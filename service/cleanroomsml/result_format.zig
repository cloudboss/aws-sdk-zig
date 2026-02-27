/// File format of the returned data.
pub const ResultFormat = enum {
    csv,
    parquet,

    pub const json_field_names = .{
        .csv = "CSV",
        .parquet = "PARQUET",
    };
};
