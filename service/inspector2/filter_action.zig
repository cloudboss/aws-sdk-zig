pub const FilterAction = enum {
    none,
    suppress,

    pub const json_field_names = .{
        .none = "NONE",
        .suppress = "SUPPRESS",
    };
};
