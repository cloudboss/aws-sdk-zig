pub const ModelOutputDataFormat = enum {
    csv,
    jsonlines,

    pub const json_field_names = .{
        .csv = "CSV",
        .jsonlines = "JSONLINES",
    };
};
