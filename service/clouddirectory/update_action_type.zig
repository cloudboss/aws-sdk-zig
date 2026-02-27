pub const UpdateActionType = enum {
    create_or_update,
    delete,

    pub const json_field_names = .{
        .create_or_update = "CREATE_OR_UPDATE",
        .delete = "DELETE",
    };
};
