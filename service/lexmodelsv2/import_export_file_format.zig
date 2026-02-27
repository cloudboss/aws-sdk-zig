pub const ImportExportFileFormat = enum {
    lex_json,
    tsv,
    csv,

    pub const json_field_names = .{
        .lex_json = "LexJson",
        .tsv = "TSV",
        .csv = "CSV",
    };
};
