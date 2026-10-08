const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const RiskType = @import("risk_type.zig").RiskType;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;

/// The report-generation filters applied when a pentest or code review report
/// is exported.
pub const ReportFilters = struct {
    /// Whether to include reviewer annotation notes under each finding.
    annotation_notes: ?bool = null,

    /// Whether to include the compliance-ready report additions.
    compliance_report: ?bool = null,

    /// The confidence levels to include in the report.
    confidence_levels: ?[]const ConfidenceLevel = null,

    /// The finding types to include in the report.
    finding_types: ?[]const []const u8 = null,

    /// The severity levels to include in the report.
    risk_levels: ?[]const RiskLevel = null,

    /// The risk types to include in the report.
    risk_types: ?[]const RiskType = null,

    /// The finding statuses to include in the report.
    statuses: ?[]const FindingStatus = null,

    /// The task execution statuses to include in the report's task table.
    task_statuses: ?[]const TaskExecutionStatus = null,

    pub const json_field_names = .{
        .annotation_notes = "annotationNotes",
        .compliance_report = "complianceReport",
        .confidence_levels = "confidenceLevels",
        .finding_types = "findingTypes",
        .risk_levels = "riskLevels",
        .risk_types = "riskTypes",
        .statuses = "statuses",
        .task_statuses = "taskStatuses",
    };
};
