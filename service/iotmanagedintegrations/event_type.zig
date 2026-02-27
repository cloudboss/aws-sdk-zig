pub const EventType = enum {
    device_command,
    device_command_request,
    device_discovery_status,
    device_event,
    device_life_cycle,
    device_state,
    device_ota,
    device_wss,
    connector_association,
    account_association,
    connector_error_report,

    pub const json_field_names = .{
        .device_command = "DEVICE_COMMAND",
        .device_command_request = "DEVICE_COMMAND_REQUEST",
        .device_discovery_status = "DEVICE_DISCOVERY_STATUS",
        .device_event = "DEVICE_EVENT",
        .device_life_cycle = "DEVICE_LIFE_CYCLE",
        .device_state = "DEVICE_STATE",
        .device_ota = "DEVICE_OTA",
        .device_wss = "DEVICE_WSS",
        .connector_association = "CONNECTOR_ASSOCIATION",
        .account_association = "ACCOUNT_ASSOCIATION",
        .connector_error_report = "CONNECTOR_ERROR_REPORT",
    };
};
