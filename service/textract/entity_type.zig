pub const EntityType = enum {
    key,
    value,
    column_header,
    table_title,
    table_footer,
    table_section_title,
    table_summary,
    structured_table,
    semi_structured_table,

    pub const json_field_names = .{
        .key = "KEY",
        .value = "VALUE",
        .column_header = "COLUMN_HEADER",
        .table_title = "TABLE_TITLE",
        .table_footer = "TABLE_FOOTER",
        .table_section_title = "TABLE_SECTION_TITLE",
        .table_summary = "TABLE_SUMMARY",
        .structured_table = "STRUCTURED_TABLE",
        .semi_structured_table = "SEMI_STRUCTURED_TABLE",
    };
};
