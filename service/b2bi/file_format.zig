pub const FileFormat = enum {
    xml,
    json,
    not_used,

    pub const json_field_names = .{
        .xml = "XML",
        .json = "JSON",
        .not_used = "NOT_USED",
    };
};
