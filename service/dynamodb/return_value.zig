pub const ReturnValue = enum {
    none,
    all_old,
    updated_old,
    all_new,
    updated_new,

    pub const json_field_names = .{
        .none = "NONE",
        .all_old = "ALL_OLD",
        .updated_old = "UPDATED_OLD",
        .all_new = "ALL_NEW",
        .updated_new = "UPDATED_NEW",
    };
};
