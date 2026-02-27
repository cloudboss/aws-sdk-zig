pub const AccountPlanType = enum {
    free,
    paid,

    pub const json_field_names = .{
        .free = "FREE",
        .paid = "PAID",
    };
};
