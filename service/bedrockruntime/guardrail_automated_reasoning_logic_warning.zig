const GuardrailAutomatedReasoningStatement = @import("guardrail_automated_reasoning_statement.zig").GuardrailAutomatedReasoningStatement;
const GuardrailAutomatedReasoningLogicWarningType = @import("guardrail_automated_reasoning_logic_warning_type.zig").GuardrailAutomatedReasoningLogicWarningType;

/// Identifies logical issues in the translated statements that exist
/// independent of any policy rules, such as statements that are always true or
/// always false.
pub const GuardrailAutomatedReasoningLogicWarning = struct {
    /// The logical statements that are validated while assuming the policy and
    /// premises.
    claims: ?[]const GuardrailAutomatedReasoningStatement,

    /// The logical statements that serve as premises under which the claims are
    /// validated.
    premises: ?[]const GuardrailAutomatedReasoningStatement,

    /// The category of the detected logical issue, such as statements that are
    /// always true or always false.
    type: ?GuardrailAutomatedReasoningLogicWarningType,

    pub const json_field_names = .{
        .claims = "claims",
        .premises = "premises",
        .type = "type",
    };
};
