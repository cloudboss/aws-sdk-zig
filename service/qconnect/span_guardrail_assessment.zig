const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const GuardrailPolicyResult = @import("guardrail_policy_result.zig").GuardrailPolicyResult;
const GuardrailSource = @import("guardrail_source.zig").GuardrailSource;

/// Result of a single guardrail assessment, covering either the input
/// (customer/user message) or the output (LLM response) of a Bedrock Converse
/// call.
pub const SpanGuardrailAssessment = struct {
    /// Outcome of the guardrail assessment.
    action: GuardrailAction,

    /// Unique AI Guardrail identifier.
    guardrail_id: []const u8,

    /// Customer-defined display name of the AI Guardrail resource.
    guardrail_name: []const u8,

    /// Per-policy assessment results. Absent or empty when action is NONE.
    policies: ?[]const GuardrailPolicyResult = null,

    /// Content source the guardrail was evaluated against.
    source: GuardrailSource,

    pub const json_field_names = .{
        .action = "action",
        .guardrail_id = "guardrailId",
        .guardrail_name = "guardrailName",
        .policies = "policies",
        .source = "source",
    };
};
