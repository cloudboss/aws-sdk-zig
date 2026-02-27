/// The type of change pending for the ActiveMQ user.
pub const ChangeType = enum {
    create,
    update,
    delete,

    pub const json_field_names = .{
        .create = "CREATE",
        .update = "UPDATE",
        .delete = "DELETE",
    };
};
