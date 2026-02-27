pub const SyncAction = enum {
    start_sync,
    no_action,

    pub const json_field_names = .{
        .start_sync = "START_SYNC",
        .no_action = "NO_ACTION",
    };
};
