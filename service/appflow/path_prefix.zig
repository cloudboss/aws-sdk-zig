pub const PathPrefix = enum {
    execution_id,
    schema_version,

    pub const json_field_names = .{
        .execution_id = "EXECUTION_ID",
        .schema_version = "SCHEMA_VERSION",
    };
};
