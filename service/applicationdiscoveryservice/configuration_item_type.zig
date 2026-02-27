pub const ConfigurationItemType = enum {
    server,
    process,
    connections,
    application,

    pub const json_field_names = .{
        .server = "SERVER",
        .process = "PROCESS",
        .connections = "CONNECTIONS",
        .application = "APPLICATION",
    };
};
