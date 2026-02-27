pub const SchemaChangeType = enum {
    add,
    remove,
    modify,

    pub const json_field_names = .{
        .add = "ADD",
        .remove = "REMOVE",
        .modify = "MODIFY",
    };
};
