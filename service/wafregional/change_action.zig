pub const ChangeAction = enum {
    insert,
    delete,

    pub const json_field_names = .{
        .insert = "INSERT",
        .delete = "DELETE",
    };
};
