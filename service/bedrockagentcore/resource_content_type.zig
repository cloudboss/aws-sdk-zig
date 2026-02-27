pub const ResourceContentType = enum {
    text,
    blob,

    pub const json_field_names = .{
        .text = "TEXT",
        .blob = "BLOB",
    };
};
