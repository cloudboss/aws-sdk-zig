pub const EnvironmentAccountConnectionStatus = enum {
    pending,
    connected,
    rejected,

    pub const json_field_names = .{
        .pending = "PENDING",
        .connected = "CONNECTED",
        .rejected = "REJECTED",
    };
};
