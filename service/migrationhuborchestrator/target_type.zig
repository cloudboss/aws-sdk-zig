pub const TargetType = enum {
    single,
    all,
    none,

    pub const json_field_names = .{
        .single = "SINGLE",
        .all = "ALL",
        .none = "NONE",
    };
};
