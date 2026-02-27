pub const PropertyUpdateType = enum {
    update,
    delete,
    create,
    reset_value,

    pub const json_field_names = .{
        .update = "UPDATE",
        .delete = "DELETE",
        .create = "CREATE",
        .reset_value = "RESET_VALUE",
    };
};
