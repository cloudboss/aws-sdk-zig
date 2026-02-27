pub const Operation = enum {
    create,
    delete,
    update,

    pub const json_field_names = .{
        .create = "CREATE",
        .delete = "DELETE",
        .update = "UPDATE",
    };
};
