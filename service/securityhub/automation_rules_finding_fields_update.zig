const aws = @import("aws");

const NoteUpdate = @import("note_update.zig").NoteUpdate;
const RelatedFinding = @import("related_finding.zig").RelatedFinding;
const SeverityUpdate = @import("severity_update.zig").SeverityUpdate;
const VerificationState = @import("verification_state.zig").VerificationState;
const WorkflowUpdate = @import("workflow_update.zig").WorkflowUpdate;

/// Identifies the finding fields that the automation rule action updates when a
/// finding matches the defined criteria.
pub const AutomationRulesFindingFieldsUpdate = struct {
    /// The rule action updates the `Confidence` field of a finding.
    confidence: ?i32 = null,

    /// The rule action updates the `Criticality` field of a finding.
    criticality: ?i32 = null,

    note: ?NoteUpdate = null,

    /// The rule action updates the `RelatedFindings` field of a finding.
    related_findings: ?[]const RelatedFinding = null,

    severity: ?SeverityUpdate = null,

    /// The rule action updates the `Types` field of a finding.
    types: ?[]const []const u8 = null,

    /// The rule action updates the `UserDefinedFields` field of a finding.
    user_defined_fields: ?[]const aws.map.StringMapEntry = null,

    /// The rule action updates the `VerificationState` field of a finding.
    verification_state: ?VerificationState = null,

    workflow: ?WorkflowUpdate = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .criticality = "Criticality",
        .note = "Note",
        .related_findings = "RelatedFindings",
        .severity = "Severity",
        .types = "Types",
        .user_defined_fields = "UserDefinedFields",
        .verification_state = "VerificationState",
        .workflow = "Workflow",
    };
};
