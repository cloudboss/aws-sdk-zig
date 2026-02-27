pub const MigrationStrategy = enum {
    create_new,
    update_existing,

    pub const json_field_names = .{
        .create_new = "CREATE_NEW",
        .update_existing = "UPDATE_EXISTING",
    };
};
