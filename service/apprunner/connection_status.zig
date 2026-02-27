pub const ConnectionStatus = enum {
    pending_handshake,
    available,
    @"error",
    deleted,

    pub const json_field_names = .{
        .pending_handshake = "PENDING_HANDSHAKE",
        .available = "AVAILABLE",
        .@"error" = "ERROR",
        .deleted = "DELETED",
    };
};
