pub const MappingType = enum {
    jsonata,
    xslt,

    pub const json_field_names = .{
        .jsonata = "JSONATA",
        .xslt = "XSLT",
    };
};
