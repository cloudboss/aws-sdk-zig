pub const UpdateBehavior = enum {
    log,
    update_in_database,

    pub const json_field_names = .{
        .log = "LOG",
        .update_in_database = "UPDATE_IN_DATABASE",
    };
};
