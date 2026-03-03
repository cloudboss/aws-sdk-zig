const NonCompliantResource = @import("non_compliant_resource.zig").NonCompliantResource;
const RelatedResource = @import("related_resource.zig").RelatedResource;
const AuditFindingSeverity = @import("audit_finding_severity.zig").AuditFindingSeverity;

/// The findings (results) of the audit.
pub const AuditFinding = struct {
    /// The audit check that generated this result.
    check_name: ?[]const u8 = null,

    /// A unique identifier for this set of audit findings. This identifier is used
    /// to apply
    /// mitigation tasks to one or more sets of findings.
    finding_id: ?[]const u8 = null,

    /// The time the result (finding) was discovered.
    finding_time: ?i64 = null,

    /// Indicates whether the audit finding was suppressed or not during reporting.
    is_suppressed: ?bool = null,

    /// The resource that was found to be noncompliant with the
    /// audit check.
    non_compliant_resource: ?NonCompliantResource = null,

    /// The reason the resource was noncompliant.
    reason_for_non_compliance: ?[]const u8 = null,

    /// A code that indicates the reason that the resource was noncompliant.
    reason_for_non_compliance_code: ?[]const u8 = null,

    /// The list of related resources.
    related_resources: ?[]const RelatedResource = null,

    /// The severity of the result (finding).
    severity: ?AuditFindingSeverity = null,

    /// The ID of the audit that generated this result (finding).
    task_id: ?[]const u8 = null,

    /// The time the audit started.
    task_start_time: ?i64 = null,

    pub const json_field_names = .{
        .check_name = "checkName",
        .finding_id = "findingId",
        .finding_time = "findingTime",
        .is_suppressed = "isSuppressed",
        .non_compliant_resource = "nonCompliantResource",
        .reason_for_non_compliance = "reasonForNonCompliance",
        .reason_for_non_compliance_code = "reasonForNonComplianceCode",
        .related_resources = "relatedResources",
        .severity = "severity",
        .task_id = "taskId",
        .task_start_time = "taskStartTime",
    };
};
