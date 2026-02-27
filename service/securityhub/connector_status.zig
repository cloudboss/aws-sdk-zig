pub const ConnectorStatus = enum {
    connected,
    failed_to_connect,
    pending_configuration,
    pending_authorization,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .failed_to_connect = "FAILED_TO_CONNECT",
        .pending_configuration = "PENDING_CONFIGURATION",
        .pending_authorization = "PENDING_AUTHORIZATION",
    };
};
