pub const AccountPlanStatus = enum {
    not_started,
    active,
    expired,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };
};
