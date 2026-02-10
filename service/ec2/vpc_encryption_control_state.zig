pub const VpcEncryptionControlState = enum {
    enforce_in_progress,
    monitor_in_progress,
    enforce_failed,
    monitor_failed,
    deleting,
    deleted,
    available,
    creating,
    delete_failed,
};
