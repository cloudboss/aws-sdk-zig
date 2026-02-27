pub const AllowNotifications = enum {
    all,
    none,
    filtered,

    pub const json_field_names = .{
        .all = "ALL",
        .none = "NONE",
        .filtered = "FILTERED",
    };
};
