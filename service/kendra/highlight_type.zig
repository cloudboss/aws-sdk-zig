pub const HighlightType = enum {
    standard,
    thesaurus_synonym,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .thesaurus_synonym = "THESAURUS_SYNONYM",
    };
};
