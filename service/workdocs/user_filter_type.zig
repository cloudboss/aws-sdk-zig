pub const UserFilterType = enum {
    all,
    active_pending,

    pub const json_field_names = .{
        .all = "ALL",
        .active_pending = "ACTIVE_PENDING",
    };
};
