pub const DefinitionType = enum {
    workload_metadata,
    app_registry,

    pub const json_field_names = .{
        .workload_metadata = "WORKLOAD_METADATA",
        .app_registry = "APP_REGISTRY",
    };
};
