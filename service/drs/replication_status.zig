pub const ReplicationStatus = enum {
    stopped,
    in_progress,
    protected,
    @"error",

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .in_progress = "IN_PROGRESS",
        .protected = "PROTECTED",
        .@"error" = "ERROR",
    };
};
