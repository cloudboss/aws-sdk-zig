pub const InputFormat = enum {
    csv,
    json,
    parquet,
    excel,
    orc,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
        .parquet = "PARQUET",
        .excel = "EXCEL",
        .orc = "ORC",
    };
};
