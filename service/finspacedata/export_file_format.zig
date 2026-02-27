/// Data View Export File Format
pub const ExportFileFormat = enum {
    parquet,
    delimited_text,

    pub const json_field_names = .{
        .parquet = "PARQUET",
        .delimited_text = "DELIMITED_TEXT",
    };
};
