pub const ViewUpdateAction = enum {
    add,
    replace,
    add_or_replace,
    drop,

    pub const json_field_names = .{
        .add = "ADD",
        .replace = "REPLACE",
        .add_or_replace = "ADD_OR_REPLACE",
        .drop = "DROP",
    };
};
