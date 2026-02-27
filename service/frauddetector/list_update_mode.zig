pub const ListUpdateMode = enum {
    replace,
    append,
    remove,

    pub const json_field_names = .{
        .replace = "REPLACE",
        .append = "APPEND",
        .remove = "REMOVE",
    };
};
