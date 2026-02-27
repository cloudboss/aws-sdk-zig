pub const AccountState = enum {
    pending_activation,
    active,
    suspended,
    pending_closure,
    closed,

    pub const json_field_names = .{
        .pending_activation = "PENDING_ACTIVATION",
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
        .pending_closure = "PENDING_CLOSURE",
        .closed = "CLOSED",
    };
};
