pub const ExportFormat = enum {
    parquet,
    csv,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .csv = "CSV",
    };
};
