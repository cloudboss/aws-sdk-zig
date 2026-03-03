const AgentActionGroup = @import("agent_action_group.zig").AgentActionGroup;
const AgentCollaboration = @import("agent_collaboration.zig").AgentCollaboration;
const CollaboratorConfiguration = @import("collaborator_configuration.zig").CollaboratorConfiguration;
const GuardrailConfigurationWithArn = @import("guardrail_configuration_with_arn.zig").GuardrailConfigurationWithArn;
const KnowledgeBase = @import("knowledge_base.zig").KnowledgeBase;
const PromptOverrideConfiguration = @import("prompt_override_configuration.zig").PromptOverrideConfiguration;

/// List of inline collaborators.
pub const Collaborator = struct {
    /// List of action groups with each action group defining tasks the inline
    /// collaborator agent needs to carry out.
    action_groups: ?[]const AgentActionGroup = null,

    /// Defines how the inline supervisor agent handles information across multiple
    /// collaborator agents to coordinate a final response.
    agent_collaboration: ?AgentCollaboration = null,

    /// Name of the inline collaborator agent which must be the same name as
    /// specified for `collaboratorName`.
    agent_name: ?[]const u8 = null,

    /// Settings of the collaborator agent.
    collaborator_configurations: ?[]const CollaboratorConfiguration = null,

    /// The Amazon Resource Name (ARN) of the AWS KMS key that encrypts the inline
    /// collaborator.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The foundation model used by the inline collaborator agent.
    foundation_model: []const u8,

    /// Details of the guardwrail associated with the inline collaborator.
    guardrail_configuration: ?GuardrailConfigurationWithArn = null,

    /// The number of seconds for which the Amazon Bedrock keeps information about
    /// the user's conversation with the inline collaborator agent.
    ///
    /// A user interaction remains active for the amount of time specified. If no
    /// conversation occurs during this time, the session expires and Amazon Bedrock
    /// deletes any data provided before the timeout.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// Instruction that tell the inline collaborator agent what it should do and
    /// how it should interact with users.
    instruction: []const u8,

    /// Knowledge base associated with the inline collaborator agent.
    knowledge_bases: ?[]const KnowledgeBase = null,

    /// Contains configurations to override prompt templates in different parts of
    /// an inline collaborator sequence. For more information, see [Advanced
    /// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    prompt_override_configuration: ?PromptOverrideConfiguration = null,

    pub const json_field_names = .{
        .action_groups = "actionGroups",
        .agent_collaboration = "agentCollaboration",
        .agent_name = "agentName",
        .collaborator_configurations = "collaboratorConfigurations",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .foundation_model = "foundationModel",
        .guardrail_configuration = "guardrailConfiguration",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .instruction = "instruction",
        .knowledge_bases = "knowledgeBases",
        .prompt_override_configuration = "promptOverrideConfiguration",
    };
};
