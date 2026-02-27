/// The format that Amazon Web Services saves the report in.
pub const ReportFormat = enum {
    csv,
    parquet,

    pub const json_field_names = .{
        .csv = "CSV",
        .parquet = "Parquet",
    };
};
