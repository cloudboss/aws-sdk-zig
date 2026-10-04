const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const GuardrailPolicyType = @import("guardrail_policy_type.zig").GuardrailPolicyType;

/// Per-policy guardrail assessment result. Captures which policy triggered, its
/// outcome, and a policy-specific detail string.
pub const GuardrailPolicyResult = struct {
    /// Outcome of this specific policy.
    action: GuardrailAction,

    /// Policy-specific detail.
    details: ?[]const u8 = null,

    /// The type of guardrail policy that was evaluated.
    policy_type: GuardrailPolicyType,

    pub const json_field_names = .{
        .action = "action",
        .details = "details",
        .policy_type = "policyType",
    };
};
