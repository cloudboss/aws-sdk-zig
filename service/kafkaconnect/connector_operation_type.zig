pub const ConnectorOperationType = enum {
    update_worker_setting,
    update_connector_configuration,
    isolate_connector,
    restore_connector,

    pub const json_field_names = .{
        .update_worker_setting = "UPDATE_WORKER_SETTING",
        .update_connector_configuration = "UPDATE_CONNECTOR_CONFIGURATION",
        .isolate_connector = "ISOLATE_CONNECTOR",
        .restore_connector = "RESTORE_CONNECTOR",
    };
};
