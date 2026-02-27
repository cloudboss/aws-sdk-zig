pub const UpdateResourceCollectionAction = enum {
    add,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .remove = "REMOVE",
    };
};
