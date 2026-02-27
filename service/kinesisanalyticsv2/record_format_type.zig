pub const RecordFormatType = enum {
    json,
    csv,

    pub const json_field_names = .{
        .json = "JSON",
        .csv = "CSV",
    };
};
