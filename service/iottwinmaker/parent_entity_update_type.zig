pub const ParentEntityUpdateType = enum {
    update,
    delete,

    pub const json_field_names = .{
        .update = "UPDATE",
        .delete = "DELETE",
    };
};
