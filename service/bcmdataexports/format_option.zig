pub const FormatOption = enum {
    text_or_csv,
    parquet,

    pub const json_field_names = .{
        .text_or_csv = "TEXT_OR_CSV",
        .parquet = "PARQUET",
    };
};
