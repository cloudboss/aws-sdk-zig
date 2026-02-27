pub const RelationshipType = enum {
    value,
    child,
    complex_features,
    merged_cell,
    title,
    answer,
    table,
    table_title,
    table_footer,

    pub const json_field_names = .{
        .value = "VALUE",
        .child = "CHILD",
        .complex_features = "COMPLEX_FEATURES",
        .merged_cell = "MERGED_CELL",
        .title = "TITLE",
        .answer = "ANSWER",
        .table = "TABLE",
        .table_title = "TABLE_TITLE",
        .table_footer = "TABLE_FOOTER",
    };
};
