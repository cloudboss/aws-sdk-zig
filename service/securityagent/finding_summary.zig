const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;

/// Contains summary information about a security finding.
pub const FindingSummary = struct {
    /// The unique identifier of the agent space associated with the finding.
    agent_space_id: []const u8,

    /// The unique identifier of the code review associated with the finding.
    code_review_id: ?[]const u8 = null,

    /// The unique identifier of the code review job that produced the finding.
    code_review_job_id: ?[]const u8 = null,

    /// The confidence level of the finding.
    confidence: ?ConfidenceLevel = null,

    /// The date and time the finding was created, in UTC format.
    created_at: ?i64 = null,

    /// The unique identifier of the finding.
    finding_id: []const u8,

    /// The name of the finding.
    name: ?[]const u8 = null,

    /// The unique identifier of the pentest associated with the finding.
    pentest_id: ?[]const u8 = null,

    /// The unique identifier of the pentest job that produced the finding.
    pentest_job_id: ?[]const u8 = null,

    /// The risk level of the finding.
    risk_level: ?RiskLevel = null,

    /// The type of security risk identified by the finding.
    risk_type: ?[]const u8 = null,

    /// The current status of the finding.
    status: ?FindingStatus = null,

    /// The date and time the finding was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// The simulated validation status of the finding.
    validation_status: ?ValidationStatus = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .confidence = "confidence",
        .created_at = "createdAt",
        .finding_id = "findingId",
        .name = "name",
        .pentest_id = "pentestId",
        .pentest_job_id = "pentestJobId",
        .risk_level = "riskLevel",
        .risk_type = "riskType",
        .status = "status",
        .updated_at = "updatedAt",
        .validation_status = "validationStatus",
    };
};
