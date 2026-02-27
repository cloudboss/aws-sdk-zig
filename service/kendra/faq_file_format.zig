pub const FaqFileFormat = enum {
    csv,
    csv_with_header,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .csv_with_header = "CSV_WITH_HEADER",
        .json = "JSON",
    };
};
