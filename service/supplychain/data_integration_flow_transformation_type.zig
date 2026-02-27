pub const DataIntegrationFlowTransformationType = enum {
    sql,
    none,

    pub const json_field_names = .{
        .sql = "SQL",
        .none = "NONE",
    };
};
