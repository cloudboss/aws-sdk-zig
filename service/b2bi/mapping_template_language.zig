pub const MappingTemplateLanguage = enum {
    xslt,
    jsonata,

    pub const json_field_names = .{
        .xslt = "XSLT",
        .jsonata = "JSONATA",
    };
};
