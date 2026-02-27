pub const ChangeAction = enum {
    add,
    modify,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .modify = "MODIFY",
        .remove = "REMOVE",
    };
};
