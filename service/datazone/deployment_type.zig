pub const DeploymentType = enum {
    create,
    update,
    delete,

    pub const json_field_names = .{
        .create = "CREATE",
        .update = "UPDATE",
        .delete = "DELETE",
    };
};
