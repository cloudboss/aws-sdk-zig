pub const Status = enum {
    preparing,
    active,
    expired,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };
};
