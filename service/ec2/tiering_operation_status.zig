pub const TieringOperationStatus = enum {
    archival_in_progress,
    archival_completed,
    archival_failed,
    temporary_restore_in_progress,
    temporary_restore_completed,
    temporary_restore_failed,
    permanent_restore_in_progress,
    permanent_restore_completed,
    permanent_restore_failed,
};
