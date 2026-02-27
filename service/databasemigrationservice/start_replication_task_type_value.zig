pub const StartReplicationTaskTypeValue = enum {
    start_replication,
    resume_processing,
    reload_target,

    pub const json_field_names = .{
        .start_replication = "START_REPLICATION",
        .resume_processing = "RESUME_PROCESSING",
        .reload_target = "RELOAD_TARGET",
    };
};
