pub const ContentCategoryType = enum {
    image,
    document,
    pdf,
    spreadsheet,
    presentation,
    audio,
    video,
    source_code,
    other,

    pub const json_field_names = .{
        .image = "IMAGE",
        .document = "DOCUMENT",
        .pdf = "PDF",
        .spreadsheet = "SPREADSHEET",
        .presentation = "PRESENTATION",
        .audio = "AUDIO",
        .video = "VIDEO",
        .source_code = "SOURCE_CODE",
        .other = "OTHER",
    };
};
