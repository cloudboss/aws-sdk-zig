pub const AccountStatus = enum {
    active,
    suspended,
    pending_closure,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
        .pending_closure = "PENDING_CLOSURE",
    };
};
