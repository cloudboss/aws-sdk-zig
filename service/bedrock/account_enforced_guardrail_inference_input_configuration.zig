const ModelEnforcement = @import("model_enforcement.zig").ModelEnforcement;
const SelectiveContentGuarding = @import("selective_content_guarding.zig").SelectiveContentGuarding;

/// Account-level enforced guardrail input configuration.
pub const AccountEnforcedGuardrailInferenceInputConfiguration = struct {
    /// Identifier for the guardrail, could be the ID or the ARN.
    guardrail_identifier: []const u8,

    /// Numerical guardrail version.
    guardrail_version: []const u8,

    /// Model-specific information for the enforced guardrail configuration. If not
    /// present, the configuration is enforced on all models
    model_enforcement: ?ModelEnforcement = null,

    /// Selective content guarding controls for enforced guardrails.
    selective_content_guarding: ?SelectiveContentGuarding = null,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .model_enforcement = "modelEnforcement",
        .selective_content_guarding = "selectiveContentGuarding",
    };
};
