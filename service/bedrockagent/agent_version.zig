const AgentCollaboration = @import("agent_collaboration.zig").AgentCollaboration;
const AgentStatus = @import("agent_status.zig").AgentStatus;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const MemoryConfiguration = @import("memory_configuration.zig").MemoryConfiguration;
const PromptOverrideConfiguration = @import("prompt_override_configuration.zig").PromptOverrideConfiguration;

/// Contains details about a version of an agent.
pub const AgentVersion = struct {
    /// The Amazon Resource Name (ARN) of the agent that the version belongs to.
    agent_arn: []const u8,

    /// The agent's collaboration settings.
    agent_collaboration: ?AgentCollaboration,

    /// The unique identifier of the agent that the version belongs to.
    agent_id: []const u8,

    /// The name of the agent that the version belongs to.
    agent_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to invoke
    /// API operations on the agent.
    agent_resource_role_arn: []const u8,

    /// The status of the agent that the version belongs to.
    agent_status: AgentStatus,

    /// The time at which the version was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that encrypts the agent.
    customer_encryption_key_arn: ?[]const u8,

    /// The description of the version.
    description: ?[]const u8,

    /// A list of reasons that the API operation on the version failed.
    failure_reasons: ?[]const []const u8,

    /// The foundation model that the version invokes.
    foundation_model: ?[]const u8,

    /// Details about the guardrail associated with the agent.
    guardrail_configuration: ?GuardrailConfiguration,

    /// The number of seconds for which Amazon Bedrock keeps information about a
    /// user's conversation with the agent.
    ///
    /// A user interaction remains active for the amount of time specified. If no
    /// conversation occurs during this time, the session expires and Amazon Bedrock
    /// deletes any data provided before the timeout.
    idle_session_ttl_in_seconds: i32,

    /// The instructions provided to the agent.
    instruction: ?[]const u8,

    /// Contains details of the memory configuration on the version of the agent.
    memory_configuration: ?MemoryConfiguration,

    /// Contains configurations to override prompt templates in different parts of
    /// an agent sequence. For more information, see [Advanced
    /// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    prompt_override_configuration: ?PromptOverrideConfiguration,

    /// A list of recommended actions to take for the failed API operation on the
    /// version to succeed.
    recommended_actions: ?[]const []const u8,

    /// The time at which the version was last updated.
    updated_at: i64,

    /// The version number.
    version: []const u8,

    pub const json_field_names = .{
        .agent_arn = "agentArn",
        .agent_collaboration = "agentCollaboration",
        .agent_id = "agentId",
        .agent_name = "agentName",
        .agent_resource_role_arn = "agentResourceRoleArn",
        .agent_status = "agentStatus",
        .created_at = "createdAt",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .description = "description",
        .failure_reasons = "failureReasons",
        .foundation_model = "foundationModel",
        .guardrail_configuration = "guardrailConfiguration",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .instruction = "instruction",
        .memory_configuration = "memoryConfiguration",
        .prompt_override_configuration = "promptOverrideConfiguration",
        .recommended_actions = "recommendedActions",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
