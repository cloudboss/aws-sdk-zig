pub const DeleteBehavior = enum {
    log,
    delete_from_database,
    deprecate_in_database,

    pub const json_field_names = .{
        .log = "LOG",
        .delete_from_database = "DELETE_FROM_DATABASE",
        .deprecate_in_database = "DEPRECATE_IN_DATABASE",
    };
};
