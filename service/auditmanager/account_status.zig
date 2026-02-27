pub const AccountStatus = enum {
    active,
    inactive,
    pending_activation,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .pending_activation = "PENDING_ACTIVATION",
    };
};
