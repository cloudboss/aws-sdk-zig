pub const RecordsFormatType = enum {
    none,
    json,

    pub const json_field_names = .{
        .none = "NONE",
        .json = "JSON",
    };
};
