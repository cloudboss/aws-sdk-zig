pub const IamRoleStatus = enum {
    associating,
    disassociating,
    failed,
    connected,
    disconnected,
    partially_connected,
    unknown,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .disassociating = "DISASSOCIATING",
        .failed = "FAILED",
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
        .partially_connected = "PARTIALLY_CONNECTED",
        .unknown = "UNKNOWN",
    };
};
