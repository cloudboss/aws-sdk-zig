pub const ResourceAction = enum {
    update,
    create,

    pub const json_field_names = .{
        .update = "UPDATE",
        .create = "CREATE",
    };
};
