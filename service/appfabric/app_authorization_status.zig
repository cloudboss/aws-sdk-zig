pub const AppAuthorizationStatus = enum {
    pending_connect,
    connected,
    connection_validation_failed,
    token_auto_rotation_failed,

    pub const json_field_names = .{
        .pending_connect = "PENDING_CONNECT",
        .connected = "CONNECTED",
        .connection_validation_failed = "CONNECTION_VALIDATION_FAILED",
        .token_auto_rotation_failed = "TOKEN_AUTO_ROTATION_FAILED",
    };
};
