pub const ContentType = enum {
    pdf,
    html,
    ms_word,
    plain_text,
    ppt,
    rtf,
    xml,
    xslt,
    ms_excel,
    csv,
    json,
    md,

    pub const json_field_names = .{
        .pdf = "PDF",
        .html = "HTML",
        .ms_word = "MS_WORD",
        .plain_text = "PLAIN_TEXT",
        .ppt = "PPT",
        .rtf = "RTF",
        .xml = "XML",
        .xslt = "XSLT",
        .ms_excel = "MS_EXCEL",
        .csv = "CSV",
        .json = "JSON",
        .md = "MD",
    };
};
