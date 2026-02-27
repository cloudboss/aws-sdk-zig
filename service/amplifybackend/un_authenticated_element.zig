pub const UnAuthenticatedElement = enum {
    read,
    create_and_update,
    delete,

    pub const json_field_names = .{
        .read = "READ",
        .create_and_update = "CREATE_AND_UPDATE",
        .delete = "DELETE",
    };
};
