/// The data storage format for Redshift query results.
pub const RedshiftResultFormat = enum {
    parquet,
    csv,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .csv = "CSV",
    };
};
