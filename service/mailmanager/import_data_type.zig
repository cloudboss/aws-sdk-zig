pub const ImportDataType = enum {
    csv,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
    };
};
