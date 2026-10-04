const GuardrailChecksPromptAttackResultEntry = @import("guardrail_checks_prompt_attack_result_entry.zig").GuardrailChecksPromptAttackResultEntry;

/// The prompt attack check results.
pub const GuardrailChecksPromptAttackResult = struct {
    /// The per-category prompt attack results.
    results: []const GuardrailChecksPromptAttackResultEntry,

    pub const json_field_names = .{
        .results = "results",
    };
};
