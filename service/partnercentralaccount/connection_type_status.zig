pub const ConnectionTypeStatus = enum {
    active,
    canceled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .canceled = "CANCELED",
    };
};
