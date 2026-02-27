pub const LimitlessDatabaseStatus = enum {
    active,
    not_in_use,
    enabled,
    disabled,
    enabling,
    disabling,
    modifying_max_capacity,
    @"error",
};
