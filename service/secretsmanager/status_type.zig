pub const StatusType = enum {
    in_sync,
    failed,
    in_progress,

    pub const json_field_names = .{
        .in_sync = "InSync",
        .failed = "Failed",
        .in_progress = "InProgress",
    };
};
