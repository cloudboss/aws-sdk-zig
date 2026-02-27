pub const UpdateType = enum {
    migration_task_state_updated,

    pub const json_field_names = .{
        .migration_task_state_updated = "MigrationTaskStateUpdated",
    };
};
