pub const FileType = enum {
    csv,
    json,
    parquet,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
        .parquet = "PARQUET",
    };
};
