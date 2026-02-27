pub const Type = enum {
    open_api_3,
    json_schema_draft_4,

    pub const json_field_names = .{
        .open_api_3 = "OpenApi3",
        .json_schema_draft_4 = "JSONSchemaDraft4",
    };
};
