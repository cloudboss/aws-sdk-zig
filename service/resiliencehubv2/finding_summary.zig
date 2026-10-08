const FailureCategory = @import("failure_category.zig").FailureCategory;
const PolicyComponent = @import("policy_component.zig").PolicyComponent;
const FindingSeverity = @import("finding_severity.zig").FindingSeverity;
const FindingStatus = @import("finding_status.zig").FindingStatus;

/// Contains summary information about a finding.
pub const FindingSummary = struct {
    description: ?[]const u8 = null,

    /// The failure category of the finding.
    failure_category: ?FailureCategory = null,

    /// The unique identifier of the finding.
    finding_id: ?[]const u8 = null,

    /// The name of the finding.
    name: ?[]const u8 = null,

    /// The policy component associated with the finding.
    policy_component: ?PolicyComponent = null,

    service_arn: ?[]const u8 = null,

    /// The severity of the finding.
    severity: ?FindingSeverity = null,

    /// The current status of the finding.
    status: ?FindingStatus = null,

    /// The timestamp when the finding was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .description = "description",
        .failure_category = "failureCategory",
        .finding_id = "findingId",
        .name = "name",
        .policy_component = "policyComponent",
        .service_arn = "serviceArn",
        .severity = "severity",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
