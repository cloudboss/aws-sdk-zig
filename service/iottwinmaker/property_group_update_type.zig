pub const PropertyGroupUpdateType = enum {
    update,
    delete,
    create,

    pub const json_field_names = .{
        .update = "UPDATE",
        .delete = "DELETE",
        .create = "CREATE",
    };
};
