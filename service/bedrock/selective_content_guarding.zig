const SelectiveGuardingMode = @import("selective_guarding_mode.zig").SelectiveGuardingMode;

/// Selective content guarding controls for enforced guardrails.
pub const SelectiveContentGuarding = struct {
    /// Selective guarding mode for user messages.
    messages: ?SelectiveGuardingMode = null,

    /// Selective guarding mode for system prompts."
    system: ?SelectiveGuardingMode = null,

    pub const json_field_names = .{
        .messages = "messages",
        .system = "system",
    };
};
