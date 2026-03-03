const aws = @import("aws");

const AIGuardrailContentPolicyConfig = @import("ai_guardrail_content_policy_config.zig").AIGuardrailContentPolicyConfig;
const AIGuardrailContextualGroundingPolicyConfig = @import("ai_guardrail_contextual_grounding_policy_config.zig").AIGuardrailContextualGroundingPolicyConfig;
const AIGuardrailSensitiveInformationPolicyConfig = @import("ai_guardrail_sensitive_information_policy_config.zig").AIGuardrailSensitiveInformationPolicyConfig;
const Status = @import("status.zig").Status;
const AIGuardrailTopicPolicyConfig = @import("ai_guardrail_topic_policy_config.zig").AIGuardrailTopicPolicyConfig;
const VisibilityStatus = @import("visibility_status.zig").VisibilityStatus;
const AIGuardrailWordPolicyConfig = @import("ai_guardrail_word_policy_config.zig").AIGuardrailWordPolicyConfig;

/// The data for the AI Guardrail
pub const AIGuardrailData = struct {
    /// The Amazon Resource Name (ARN) of the AI Guardrail.
    ai_guardrail_arn: []const u8,

    /// The identifier of the Amazon Q in Connect AI Guardrail.
    ai_guardrail_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The message to return when the AI Guardrail blocks a prompt.
    blocked_input_messaging: []const u8,

    /// The message to return when the AI Guardrail blocks a model response.
    blocked_outputs_messaging: []const u8,

    /// Contains details about how to handle harmful content.
    content_policy_config: ?AIGuardrailContentPolicyConfig = null,

    /// The policy configuration details for the AI Guardrail's contextual grounding
    /// policy.
    contextual_grounding_policy_config: ?AIGuardrailContextualGroundingPolicyConfig = null,

    /// A description of the AI Guardrail.
    description: ?[]const u8 = null,

    /// The time the AI Guardrail was last modified.
    modified_time: ?i64 = null,

    /// The name of the AI Guardrail.
    name: []const u8,

    /// Contains details about PII entities and regular expressions to configure for
    /// the AI Guardrail.
    sensitive_information_policy_config: ?AIGuardrailSensitiveInformationPolicyConfig = null,

    /// The status of the AI Guardrail.
    status: ?Status = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Contains details about topics that the AI Guardrail should identify and
    /// deny.
    topic_policy_config: ?AIGuardrailTopicPolicyConfig = null,

    /// The visibility status of the AI Guardrail.
    visibility_status: VisibilityStatus,

    /// Contains details about the word policy to configured for the AI Guardrail.
    word_policy_config: ?AIGuardrailWordPolicyConfig = null,

    pub const json_field_names = .{
        .ai_guardrail_arn = "aiGuardrailArn",
        .ai_guardrail_id = "aiGuardrailId",
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .blocked_input_messaging = "blockedInputMessaging",
        .blocked_outputs_messaging = "blockedOutputsMessaging",
        .content_policy_config = "contentPolicyConfig",
        .contextual_grounding_policy_config = "contextualGroundingPolicyConfig",
        .description = "description",
        .modified_time = "modifiedTime",
        .name = "name",
        .sensitive_information_policy_config = "sensitiveInformationPolicyConfig",
        .status = "status",
        .tags = "tags",
        .topic_policy_config = "topicPolicyConfig",
        .visibility_status = "visibilityStatus",
        .word_policy_config = "wordPolicyConfig",
    };
};
