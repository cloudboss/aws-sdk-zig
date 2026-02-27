pub const EventClass = enum {
    infrastructure,
    deployment,
    security_change,
    config_change,
    schema_change,

    pub const json_field_names = .{
        .infrastructure = "INFRASTRUCTURE",
        .deployment = "DEPLOYMENT",
        .security_change = "SECURITY_CHANGE",
        .config_change = "CONFIG_CHANGE",
        .schema_change = "SCHEMA_CHANGE",
    };
};
