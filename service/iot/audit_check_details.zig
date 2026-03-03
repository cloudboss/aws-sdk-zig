const AuditCheckRunStatus = @import("audit_check_run_status.zig").AuditCheckRunStatus;

/// Information about the audit check.
pub const AuditCheckDetails = struct {
    /// True if the check is complete and found all resources compliant.
    check_compliant: ?bool = null,

    /// The completion status of this check. One of "IN_PROGRESS",
    /// "WAITING_FOR_DATA_COLLECTION",
    /// "CANCELED", "COMPLETED_COMPLIANT", "COMPLETED_NON_COMPLIANT", or "FAILED".
    check_run_status: ?AuditCheckRunStatus = null,

    /// The code of any error encountered when this check is performed during this
    /// audit.
    /// One of "INSUFFICIENT_PERMISSIONS" or "AUDIT_CHECK_DISABLED".
    error_code: ?[]const u8 = null,

    /// The message associated with any error encountered when this check is
    /// performed during this audit.
    message: ?[]const u8 = null,

    /// The number of resources that were found noncompliant during the check.
    non_compliant_resources_count: ?i64 = null,

    /// Describes how many of the non-compliant resources created during the
    /// evaluation of an audit check were marked as suppressed.
    suppressed_non_compliant_resources_count: ?i64 = null,

    /// The number of resources on which the check was performed.
    total_resources_count: ?i64 = null,

    pub const json_field_names = .{
        .check_compliant = "checkCompliant",
        .check_run_status = "checkRunStatus",
        .error_code = "errorCode",
        .message = "message",
        .non_compliant_resources_count = "nonCompliantResourcesCount",
        .suppressed_non_compliant_resources_count = "suppressedNonCompliantResourcesCount",
        .total_resources_count = "totalResourcesCount",
    };
};
