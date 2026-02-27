pub const Gid = enum {
    none,
    int_value,
    name,
    both,

    pub const json_field_names = .{
        .none = "NONE",
        .int_value = "INT_VALUE",
        .name = "NAME",
        .both = "BOTH",
    };
};
