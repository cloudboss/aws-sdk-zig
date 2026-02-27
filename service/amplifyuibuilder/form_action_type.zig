pub const FormActionType = enum {
    create,
    update,

    pub const json_field_names = .{
        .create = "CREATE",
        .update = "UPDATE",
    };
};
