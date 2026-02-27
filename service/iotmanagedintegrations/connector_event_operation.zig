pub const ConnectorEventOperation = enum {
    device_command_response,
    device_discovery,
    device_event,
    device_command_request,

    pub const json_field_names = .{
        .device_command_response = "DEVICE_COMMAND_RESPONSE",
        .device_discovery = "DEVICE_DISCOVERY",
        .device_event = "DEVICE_EVENT",
        .device_command_request = "DEVICE_COMMAND_REQUEST",
    };
};
