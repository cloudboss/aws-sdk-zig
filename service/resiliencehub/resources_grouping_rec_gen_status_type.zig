pub const ResourcesGroupingRecGenStatusType = enum {
    pending,
    in_progress,
    failed,
    success,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .success = "SUCCESS",
    };
};
