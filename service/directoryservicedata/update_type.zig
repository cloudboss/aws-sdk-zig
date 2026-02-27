pub const UpdateType = enum {
    add,
    replace,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .replace = "REPLACE",
        .remove = "REMOVE",
    };
};
