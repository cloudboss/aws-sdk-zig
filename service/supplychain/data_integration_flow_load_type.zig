pub const DataIntegrationFlowLoadType = enum {
    incremental,
    replace,

    pub const json_field_names = .{
        .incremental = "INCREMENTAL",
        .replace = "REPLACE",
    };
};
