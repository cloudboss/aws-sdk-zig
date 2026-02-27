pub const StackInstanceDetailedStatus = enum {
    pending,
    running,
    succeeded,
    failed,
    cancelled,
    inoperable,
    skipped_suspended_account,
    failed_import,
};
