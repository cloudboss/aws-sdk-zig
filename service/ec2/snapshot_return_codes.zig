pub const SnapshotReturnCodes = enum {
    success,
    warn_skipped,
    error_missing_permissions,
    error_code_internal_error,
    error_code_client_error,
};
