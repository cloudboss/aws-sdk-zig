pub const QueryResultType = enum {
    data_manifest,
    data_rows,

    pub const json_field_names = .{
        .data_manifest = "DATA_MANIFEST",
        .data_rows = "DATA_ROWS",
    };
};
