/// Statistics for the checks performed during the audit.
pub const TaskStatistics = struct {
    /// The number of checks that did not run because the audit was canceled.
    canceled_checks: ?i32 = null,

    /// The number of checks that found compliant resources.
    compliant_checks: ?i32 = null,

    /// The number of checks.
    failed_checks: ?i32 = null,

    /// The number of checks in progress.
    in_progress_checks: ?i32 = null,

    /// The number of checks that found noncompliant resources.
    non_compliant_checks: ?i32 = null,

    /// The number of checks in this audit.
    total_checks: ?i32 = null,

    /// The number of checks waiting for data collection.
    waiting_for_data_collection_checks: ?i32 = null,

    pub const json_field_names = .{
        .canceled_checks = "canceledChecks",
        .compliant_checks = "compliantChecks",
        .failed_checks = "failedChecks",
        .in_progress_checks = "inProgressChecks",
        .non_compliant_checks = "nonCompliantChecks",
        .total_checks = "totalChecks",
        .waiting_for_data_collection_checks = "waitingForDataCollectionChecks",
    };
};
