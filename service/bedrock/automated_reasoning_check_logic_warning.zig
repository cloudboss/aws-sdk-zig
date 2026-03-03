const AutomatedReasoningLogicStatement = @import("automated_reasoning_logic_statement.zig").AutomatedReasoningLogicStatement;
const AutomatedReasoningCheckLogicWarningType = @import("automated_reasoning_check_logic_warning_type.zig").AutomatedReasoningCheckLogicWarningType;

/// Identifies logical issues in the translated statements that exist
/// independent of any policy rules, such as statements that are always true or
/// always false.
pub const AutomatedReasoningCheckLogicWarning = struct {
    /// The logical statements that are validated while assuming the policy and
    /// premises.
    claims: ?[]const AutomatedReasoningLogicStatement = null,

    /// The logical statements that serve as premises under which the claims are
    /// validated.
    premises: ?[]const AutomatedReasoningLogicStatement = null,

    /// The category of the detected logical issue, such as statements that are
    /// always true or always false.
    @"type": ?AutomatedReasoningCheckLogicWarningType = null,

    pub const json_field_names = .{
        .claims = "claims",
        .premises = "premises",
        .@"type" = "type",
    };
};
