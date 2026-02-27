pub const SnapshotStatus = enum {
    in_progress,
    complete,
    suspended,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .suspended = "SUSPENDED",
    };
};
