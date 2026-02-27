const AIGuardrailSummary = @import("ai_guardrail_summary.zig").AIGuardrailSummary;

/// The summary of the AI Guardrail version.
pub const AIGuardrailVersionSummary = struct {
    /// The data for the summary of the AI Guardrail version.
    ai_guardrail_summary: ?AIGuardrailSummary,

    /// The version number for this AI Guardrail version.
    version_number: ?i64,

    pub const json_field_names = .{
        .ai_guardrail_summary = "aiGuardrailSummary",
        .version_number = "versionNumber",
    };
};
