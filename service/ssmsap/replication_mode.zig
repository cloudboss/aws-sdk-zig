pub const ReplicationMode = enum {
    primary,
    none,
    sync,
    syncmem,
    async,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .none = "NONE",
        .sync = "SYNC",
        .syncmem = "SYNCMEM",
        .async = "ASYNC",
    };
};
