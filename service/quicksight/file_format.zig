pub const FileFormat = enum {
    csv,
    tsv,
    clf,
    elf,
    xlsx,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .tsv = "TSV",
        .clf = "CLF",
        .elf = "ELF",
        .xlsx = "XLSX",
        .json = "JSON",
    };
};
