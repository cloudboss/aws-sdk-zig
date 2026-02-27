pub const Type = enum {
    all,
    any,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .any = "ANY",
        .none = "NONE",
    };
};
