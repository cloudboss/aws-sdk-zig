pub const TerminologyDataFormat = enum {
    csv,
    tmx,
    tsv,

    pub const json_field_names = .{
        .csv = "CSV",
        .tmx = "TMX",
        .tsv = "TSV",
    };
};
