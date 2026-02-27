pub const StartReplicationMigrationTypeValue = enum {
    reload_target,
    resume_processing,
    start_replication,

    pub const json_field_names = .{
        .reload_target = "RELOAD_TARGET",
        .resume_processing = "RESUME_PROCESSING",
        .start_replication = "START_REPLICATION",
    };
};
