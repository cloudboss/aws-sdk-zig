pub const DocumentFormat = enum {
    pdf,
    csv,
    doc,
    docx,
    xls,
    xlsx,
    html,
    txt,
    md,

    pub const json_field_names = .{
        .pdf = "PDF",
        .csv = "CSV",
        .doc = "DOC",
        .docx = "DOCX",
        .xls = "XLS",
        .xlsx = "XLSX",
        .html = "HTML",
        .txt = "TXT",
        .md = "MD",
    };
};
