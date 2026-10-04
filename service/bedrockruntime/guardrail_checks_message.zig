const GuardrailChecksContentBlock = @import("guardrail_checks_content_block.zig").GuardrailChecksContentBlock;
const GuardrailChecksRole = @import("guardrail_checks_role.zig").GuardrailChecksRole;

/// A message to evaluate against guardrail checks, containing a role and
/// content blocks.
pub const GuardrailChecksMessage = struct {
    /// The content blocks for the message.
    content: []const GuardrailChecksContentBlock,

    /// The role of the message sender.
    role: GuardrailChecksRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
