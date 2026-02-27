pub const ParallelDataFormat = enum {
    tsv,
    csv,
    tmx,

    pub const json_field_names = .{
        .tsv = "TSV",
        .csv = "CSV",
        .tmx = "TMX",
    };
};
