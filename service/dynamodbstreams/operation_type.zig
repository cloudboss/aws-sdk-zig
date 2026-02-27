pub const OperationType = enum {
    insert,
    modify,
    remove,

    pub const json_field_names = .{
        .insert = "INSERT",
        .modify = "MODIFY",
        .remove = "REMOVE",
    };
};
