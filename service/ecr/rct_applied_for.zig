pub const RCTAppliedFor = enum {
    replication,
    pull_through_cache,
    create_on_push,

    pub const json_field_names = .{
        .replication = "REPLICATION",
        .pull_through_cache = "PULL_THROUGH_CACHE",
        .create_on_push = "CREATE_ON_PUSH",
    };
};
