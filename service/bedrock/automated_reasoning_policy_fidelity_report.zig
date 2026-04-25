const aws = @import("aws");

const AutomatedReasoningPolicyReportSourceDocument = @import("automated_reasoning_policy_report_source_document.zig").AutomatedReasoningPolicyReportSourceDocument;
const AutomatedReasoningPolicyRuleReport = @import("automated_reasoning_policy_rule_report.zig").AutomatedReasoningPolicyRuleReport;
const AutomatedReasoningPolicyVariableReport = @import("automated_reasoning_policy_variable_report.zig").AutomatedReasoningPolicyVariableReport;

/// A comprehensive analysis report that measures how accurately a generated
/// policy represents the source documents. The report includes coverage and
/// accuracy scores, detailed grounding information linking policy elements to
/// source statements, and annotated document content.
pub const AutomatedReasoningPolicyFidelityReport = struct {
    /// A score from 0.0 to 1.0 indicating how accurate the policy rules are
    /// relative to the source documents. A higher score means the policy rules more
    /// faithfully represent the source material.
    accuracy_score: f64,

    /// A score from 0.0 to 1.0 indicating how well the policy covers the statements
    /// in the source documents. A higher score means more of the source content is
    /// represented in the policy.
    coverage_score: f64,

    /// A list of source documents with their content broken down into atomic
    /// statements and annotated with line numbers for precise referencing.
    document_sources: []const AutomatedReasoningPolicyReportSourceDocument,

    /// A mapping from rule identifiers to detailed fidelity reports for each rule,
    /// showing which source statements ground each rule and how accurate it is.
    rule_reports: []const aws.map.MapEntry(AutomatedReasoningPolicyRuleReport),

    /// A mapping from variable names to detailed fidelity reports for each
    /// variable, showing which source statements ground each variable and how
    /// accurate it is.
    variable_reports: []const aws.map.MapEntry(AutomatedReasoningPolicyVariableReport),

    pub const json_field_names = .{
        .accuracy_score = "accuracyScore",
        .coverage_score = "coverageScore",
        .document_sources = "documentSources",
        .rule_reports = "ruleReports",
        .variable_reports = "variableReports",
    };
};
