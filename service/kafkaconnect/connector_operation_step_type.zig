pub const ConnectorOperationStepType = enum {
    initialize_update,
    finalize_update,
    update_worker_setting,
    update_connector_configuration,
    validate_update,

    pub const json_field_names = .{
        .initialize_update = "INITIALIZE_UPDATE",
        .finalize_update = "FINALIZE_UPDATE",
        .update_worker_setting = "UPDATE_WORKER_SETTING",
        .update_connector_configuration = "UPDATE_CONNECTOR_CONFIGURATION",
        .validate_update = "VALIDATE_UPDATE",
    };
};
