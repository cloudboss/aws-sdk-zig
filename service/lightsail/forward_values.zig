pub const ForwardValues = enum {
    none,
    allow_list,
    all,

    pub const json_field_names = .{
        .none = "none",
        .allow_list = "allowList",
        .all = "all",
    };
};
