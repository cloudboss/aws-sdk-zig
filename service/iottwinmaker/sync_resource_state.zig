pub const SyncResourceState = enum {
    initializing,
    processing,
    deleted,
    in_sync,
    @"error",

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .processing = "PROCESSING",
        .deleted = "DELETED",
        .in_sync = "IN_SYNC",
        .@"error" = "ERROR",
    };
};
