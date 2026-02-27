/// Scte27 Ocr Language
pub const Scte27OcrLanguage = enum {
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
