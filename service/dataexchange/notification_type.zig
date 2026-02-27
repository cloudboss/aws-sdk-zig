pub const NotificationType = enum {
    data_delay,
    data_update,
    deprecation,
    schema_change,

    pub const json_field_names = .{
        .data_delay = "DATA_DELAY",
        .data_update = "DATA_UPDATE",
        .deprecation = "DEPRECATION",
        .schema_change = "SCHEMA_CHANGE",
    };
};
