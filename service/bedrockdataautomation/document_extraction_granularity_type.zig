pub const DocumentExtractionGranularityType = enum {
    document,
    page,
    element,
    word,
    line,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .page = "PAGE",
        .element = "ELEMENT",
        .word = "WORD",
        .line = "LINE",
    };
};
