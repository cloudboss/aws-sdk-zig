const GuardrailTopicPolicyAction = @import("guardrail_topic_policy_action.zig").GuardrailTopicPolicyAction;
const GuardrailTopicType = @import("guardrail_topic_type.zig").GuardrailTopicType;

/// The details for a specific topic defined in the Guardrail.
pub const GuardrailTopic = struct {
    /// The action details on a specific topic in the Guardrail.
    action: ?GuardrailTopicPolicyAction = null,

    /// The name details on a specific topic in the Guardrail.
    name: ?[]const u8 = null,

    /// The type details on a specific topic in the Guardrail.
    @"type": ?GuardrailTopicType = null,

    pub const json_field_names = .{
        .action = "action",
        .name = "name",
        .@"type" = "type",
    };
};
