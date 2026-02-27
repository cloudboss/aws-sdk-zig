pub const RerankDocumentType = enum {
    text,
    json,

    pub const json_field_names = .{
        .text = "TEXT",
        .json = "JSON",
    };
};
