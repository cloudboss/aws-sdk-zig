pub const UpdateCatalogBehavior = enum {
    update_in_database,
    log,

    pub const json_field_names = .{
        .update_in_database = "UPDATE_IN_DATABASE",
        .log = "LOG",
    };
};
