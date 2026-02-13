const CompliantSummary = @import("compliant_summary.zig").CompliantSummary;
const ComplianceExecutionSummary = @import("compliance_execution_summary.zig").ComplianceExecutionSummary;
const NonCompliantSummary = @import("non_compliant_summary.zig").NonCompliantSummary;
const ComplianceSeverity = @import("compliance_severity.zig").ComplianceSeverity;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Compliance summary information for a specific resource.
pub const ResourceComplianceSummaryItem = struct {
    /// The compliance type.
    compliance_type: ?[]const u8,

    /// A list of items that are compliant for the resource.
    compliant_summary: ?CompliantSummary,

    /// Information about the execution.
    execution_summary: ?ComplianceExecutionSummary,

    /// A list of items that aren't compliant for the resource.
    non_compliant_summary: ?NonCompliantSummary,

    /// The highest severity item found for the resource. The resource is compliant
    /// for this
    /// item.
    overall_severity: ?ComplianceSeverity,

    /// The resource ID.
    resource_id: ?[]const u8,

    /// The resource type.
    resource_type: ?[]const u8,

    /// The compliance status for the resource.
    status: ?ComplianceStatus,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .compliant_summary = "CompliantSummary",
        .execution_summary = "ExecutionSummary",
        .non_compliant_summary = "NonCompliantSummary",
        .overall_severity = "OverallSeverity",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .status = "Status",
    };
};
