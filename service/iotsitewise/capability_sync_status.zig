pub const CapabilitySyncStatus = enum {
    in_sync,
    out_of_sync,
    sync_failed,
    unknown,
    not_applicable,

    pub const json_field_names = .{
        .in_sync = "IN_SYNC",
        .out_of_sync = "OUT_OF_SYNC",
        .sync_failed = "SYNC_FAILED",
        .unknown = "UNKNOWN",
        .not_applicable = "NOT_APPLICABLE",
    };
};
