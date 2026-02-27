/// The type of structured output format. Available options are: json_schema.
pub const OutputFormatType = enum {
    json_schema,

    pub const json_field_names = .{
        .json_schema = "JSON_SCHEMA",
    };
};
