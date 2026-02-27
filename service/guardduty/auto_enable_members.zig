pub const AutoEnableMembers = enum {
    new,
    all,
    none,

    pub const json_field_names = .{
        .new = "NEW",
        .all = "ALL",
        .none = "NONE",
    };
};
