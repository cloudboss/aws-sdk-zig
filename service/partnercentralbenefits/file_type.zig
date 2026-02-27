pub const FileType = enum {
    doc,
    docx,
    xlsx,
    pptx,
    pdf,
    png,
    jpg,
    svg,
    csv,

    pub const json_field_names = .{
        .doc = "DOC",
        .docx = "DOCX",
        .xlsx = "XLSX",
        .pptx = "PPTX",
        .pdf = "PDF",
        .png = "PNG",
        .jpg = "JPG",
        .svg = "SVG",
        .csv = "CSV",
    };
};
