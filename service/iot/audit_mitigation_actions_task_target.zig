const aws = @import("aws");

/// Used in MitigationActionParams, this information identifies the target
/// findings to which the mitigation actions are applied. Only one entry
/// appears.
pub const AuditMitigationActionsTaskTarget = struct {
    /// Specifies a filter in the form of an audit check and set of reason codes
    /// that identify the findings from the audit to which the audit mitigation
    /// actions task apply.
    audit_check_to_reason_code_filter: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// If the task will apply a mitigation action to findings from a specific
    /// audit, this value uniquely identifies the audit.
    audit_task_id: ?[]const u8 = null,

    /// If the task will apply a mitigation action to one or more listed findings,
    /// this value uniquely identifies those findings.
    finding_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .audit_check_to_reason_code_filter = "auditCheckToReasonCodeFilter",
        .audit_task_id = "auditTaskId",
        .finding_ids = "findingIds",
    };
};
