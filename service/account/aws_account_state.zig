pub const AwsAccountState = enum {
    pending_activation,
    active,
    suspended,
    closed,

    pub const json_field_names = .{
        .pending_activation = "PENDING_ACTIVATION",
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
        .closed = "CLOSED",
    };
};
