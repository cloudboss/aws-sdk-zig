/// Dvb Sub Ocr Language
pub const DvbSubOcrLanguage = enum {
    deu,
    eng,
    fra,
    nld,
    por,
    spa,

    pub const json_field_names = .{
        .deu = "DEU",
        .eng = "ENG",
        .fra = "FRA",
        .nld = "NLD",
        .por = "POR",
        .spa = "SPA",
    };
};
