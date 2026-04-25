const AutomatedReasoningPolicyStatementReference = @import("automated_reasoning_policy_statement_reference.zig").AutomatedReasoningPolicyStatementReference;

/// Provides detailed fidelity analysis for a specific policy variable,
/// including which source document statements support it and how accurate the
/// variable definition is.
pub const AutomatedReasoningPolicyVariableReport = struct {
    /// A textual explanation of the accuracy score, describing why the variable
    /// received this particular accuracy rating.
    accuracy_justification: ?[]const u8 = null,

    /// A score from 0.0 to 1.0 indicating how accurately this variable represents
    /// concepts from the source material.
    accuracy_score: ?f64 = null,

    /// Explanations describing how the source statements support and justify this
    /// specific variable definition.
    grounding_justifications: ?[]const []const u8 = null,

    /// References to statements from the source documents that provide the basis or
    /// justification for this variable.
    grounding_statements: ?[]const AutomatedReasoningPolicyStatementReference = null,

    /// The name of the policy variable being analyzed in this report.
    policy_variable: []const u8,

    pub const json_field_names = .{
        .accuracy_justification = "accuracyJustification",
        .accuracy_score = "accuracyScore",
        .grounding_justifications = "groundingJustifications",
        .grounding_statements = "groundingStatements",
        .policy_variable = "policyVariable",
    };
};
