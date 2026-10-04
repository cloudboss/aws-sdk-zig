const EvaluationFormValidationFindingItem = @import("evaluation_form_validation_finding_item.zig").EvaluationFormValidationFindingItem;
const EvaluationFormValidationFindingSeverity = @import("evaluation_form_validation_finding_severity.zig").EvaluationFormValidationFindingSeverity;

/// Information about a finding from the evaluation form validation process.
/// Each finding identifies a structural
/// issue or quality improvement opportunity for the evaluation form.
pub const EvaluationFormValidationFinding = struct {
    /// A description of the validation issue.
    description: []const u8,

    /// A code that identifies the type of validation issue found.
    issue_code: []const u8,

    /// A list of evaluation form items affected by this finding.
    items: ?[]const EvaluationFormValidationFindingItem = null,

    /// The severity of the finding. Valid values: `WARNING`, `ERROR`.
    severity: EvaluationFormValidationFindingSeverity,

    /// A suggested fix for the validation issue.
    suggestion: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .issue_code = "IssueCode",
        .items = "Items",
        .severity = "Severity",
        .suggestion = "Suggestion",
    };
};
