pub const DbServerPatchingStatus = enum {
    complete,
    failed,
    maintenance_in_progress,
    scheduled,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .failed = "FAILED",
        .maintenance_in_progress = "MAINTENANCE_IN_PROGRESS",
        .scheduled = "SCHEDULED",
    };
};
