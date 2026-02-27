pub const SchemaVersionType = enum {
    capability,
    definition,

    pub const json_field_names = .{
        .capability = "CAPABILITY",
        .definition = "DEFINITION",
    };
};
