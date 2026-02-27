pub const Operation = enum {
    replace,
    remove,

    pub const json_field_names = .{
        .replace = "replace",
        .remove = "remove",
    };
};
