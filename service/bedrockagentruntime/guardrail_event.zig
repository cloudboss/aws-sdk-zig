const GuadrailAction = @import("guadrail_action.zig").GuadrailAction;

/// A guardrail event.
pub const GuardrailEvent = struct {
    /// The guardrail action.
    action: ?GuadrailAction = null,

    pub const json_field_names = .{
        .action = "action",
    };
};
