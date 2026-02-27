pub const SourceApiAssociationStatus = enum {
    merge_scheduled,
    merge_failed,
    merge_success,
    merge_in_progress,
    auto_merge_schedule_failed,
    deletion_scheduled,
    deletion_in_progress,
    deletion_failed,

    pub const json_field_names = .{
        .merge_scheduled = "MERGE_SCHEDULED",
        .merge_failed = "MERGE_FAILED",
        .merge_success = "MERGE_SUCCESS",
        .merge_in_progress = "MERGE_IN_PROGRESS",
        .auto_merge_schedule_failed = "AUTO_MERGE_SCHEDULE_FAILED",
        .deletion_scheduled = "DELETION_SCHEDULED",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .deletion_failed = "DELETION_FAILED",
    };
};
