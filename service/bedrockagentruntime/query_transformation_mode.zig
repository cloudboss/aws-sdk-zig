pub const QueryTransformationMode = enum {
    text_to_sql,

    pub const json_field_names = .{
        .text_to_sql = "TEXT_TO_SQL",
    };
};
