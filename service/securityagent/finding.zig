const CodeLocation = @import("code_location.zig").CodeLocation;
const CodeRemediationTask = @import("code_remediation_task.zig").CodeRemediationTask;
const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;
const VerificationScript = @import("verification_script.zig").VerificationScript;

/// Represents a security finding discovered during a pentest job. A finding
/// contains details about a vulnerability, including its risk level,
/// confidence, and remediation status.
pub const Finding = struct {
    /// The unique identifier of the agent space associated with the finding.
    agent_space_id: []const u8,

    /// The rationale provided by the alignment agent explaining how the finding was
    /// adjusted based on customer preferences.
    alignment_rationale: ?[]const u8 = null,

    /// The attack script used to reproduce the finding.
    attack_script: ?[]const u8 = null,

    /// The file locations involved in the vulnerability, as reported by the code
    /// scanner.
    code_locations: ?[]const CodeLocation = null,

    /// The code remediation task associated with the finding, if code remediation
    /// was initiated.
    code_remediation_task: ?CodeRemediationTask = null,

    /// The unique identifier of the code review associated with the finding.
    code_review_id: ?[]const u8 = null,

    /// The unique identifier of the code review job that produced the finding.
    code_review_job_id: ?[]const u8 = null,

    /// The confidence level of the finding. Valid values include FALSE_POSITIVE,
    /// UNCONFIRMED, LOW, MEDIUM, and HIGH.
    confidence: ?ConfidenceLevel = null,

    /// The date and time the finding was created, in UTC format.
    created_at: ?i64 = null,

    /// A customer-provided note on the finding.
    customer_note: ?[]const u8 = null,

    /// A description of the finding.
    description: ?[]const u8 = null,

    /// The unique identifier of the finding.
    finding_id: []const u8,

    /// The identifier of the entity that last updated the finding.
    last_updated_by: ?[]const u8 = null,

    /// The name of the finding.
    name: ?[]const u8 = null,

    /// The identifier of the original finding that this revalidation finding was
    /// produced from.
    original_finding_id: ?[]const u8 = null,

    /// The unique identifier of the pentest associated with the finding.
    pentest_id: ?[]const u8 = null,

    /// The unique identifier of the pentest job that produced the finding.
    pentest_job_id: ?[]const u8 = null,

    /// The reasoning behind the finding, explaining why it was identified as a
    /// vulnerability.
    reasoning: ?[]const u8 = null,

    /// The list of pentest job identifiers for revalidation jobs that retested this
    /// finding.
    revalidation_job_ids: ?[]const []const u8 = null,

    /// The risk level of the finding. Valid values include UNKNOWN, INFORMATIONAL,
    /// LOW, MEDIUM, HIGH, and CRITICAL.
    risk_level: ?RiskLevel = null,

    /// The numerical risk score of the finding.
    risk_score: ?[]const u8 = null,

    /// The type of security risk identified by the finding.
    risk_type: ?[]const u8 = null,

    /// The current status of the finding. Valid values include ACTIVE, RESOLVED,
    /// ACCEPTED, and FALSE_POSITIVE.
    status: ?FindingStatus = null,

    /// The unique identifier of the task that produced the finding.
    task_id: ?[]const u8 = null,

    /// The date and time the finding was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// The simulated validation status of the finding. Valid values are
    /// NOT_VALIDATED, VALIDATING, CONFIRMED, NOT_REPRODUCED, and VALIDATION_FAILED.
    validation_status: ?ValidationStatus = null,

    /// The verification script metadata for reproducing the finding, including
    /// download URL, instructions, and required environment variables.
    verification_script: ?VerificationScript = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .alignment_rationale = "alignmentRationale",
        .attack_script = "attackScript",
        .code_locations = "codeLocations",
        .code_remediation_task = "codeRemediationTask",
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .confidence = "confidence",
        .created_at = "createdAt",
        .customer_note = "customerNote",
        .description = "description",
        .finding_id = "findingId",
        .last_updated_by = "lastUpdatedBy",
        .name = "name",
        .original_finding_id = "originalFindingId",
        .pentest_id = "pentestId",
        .pentest_job_id = "pentestJobId",
        .reasoning = "reasoning",
        .revalidation_job_ids = "revalidationJobIds",
        .risk_level = "riskLevel",
        .risk_score = "riskScore",
        .risk_type = "riskType",
        .status = "status",
        .task_id = "taskId",
        .updated_at = "updatedAt",
        .validation_status = "validationStatus",
        .verification_script = "verificationScript",
    };
};
