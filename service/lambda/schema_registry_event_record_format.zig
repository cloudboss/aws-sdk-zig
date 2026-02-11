pub const SchemaRegistryEventRecordFormat = enum {
    json,
    source,

    pub const json_field_names = .{
        .json = "JSON",
        .source = "SOURCE",
    };
};
