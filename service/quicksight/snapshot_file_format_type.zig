pub const SnapshotFileFormatType = enum {
    csv,
    pdf,
    excel,

    pub const json_field_names = .{
        .csv = "CSV",
        .pdf = "PDF",
        .excel = "EXCEL",
    };
};
