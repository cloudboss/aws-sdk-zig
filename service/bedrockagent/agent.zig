const AgentCollaboration = @import("agent_collaboration.zig").AgentCollaboration;
const AgentStatus = @import("agent_status.zig").AgentStatus;
const CustomOrchestration = @import("custom_orchestration.zig").CustomOrchestration;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const MemoryConfiguration = @import("memory_configuration.zig").MemoryConfiguration;
const OrchestrationType = @import("orchestration_type.zig").OrchestrationType;
const PromptOverrideConfiguration = @import("prompt_override_configuration.zig").PromptOverrideConfiguration;

/// Contains details about an agent.
pub const Agent = struct {
    /// The Amazon Resource Name (ARN) of the agent.
    agent_arn: []const u8,

    /// The agent's collaboration settings.
    agent_collaboration: ?AgentCollaboration,

    /// The unique identifier of the agent.
    agent_id: []const u8,

    /// The name of the agent.
    agent_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to invoke
    /// API operations on the agent.
    agent_resource_role_arn: []const u8,

    /// The status of the agent and whether it is ready for use. The following
    /// statuses are possible:
    ///
    /// * CREATING – The agent is being created.
    /// * PREPARING – The agent is being prepared.
    /// * PREPARED – The agent is prepared and ready to be invoked.
    /// * NOT_PREPARED – The agent has been created but not yet prepared.
    /// * FAILED – The agent API operation failed.
    /// * UPDATING – The agent is being updated.
    /// * DELETING – The agent is being deleted.
    agent_status: AgentStatus,

    /// The version of the agent.
    agent_version: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// The time at which the agent was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that encrypts the agent.
    customer_encryption_key_arn: ?[]const u8,

    /// Contains custom orchestration configurations for the agent.
    custom_orchestration: ?CustomOrchestration,

    /// The description of the agent.
    description: ?[]const u8,

    /// Contains reasons that the agent-related API that you invoked failed.
    failure_reasons: ?[]const []const u8,

    /// The foundation model used for orchestration by the agent.
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

    /// Instructions that tell the agent what it should do and how it should
    /// interact with users.
    instruction: ?[]const u8,

    /// Contains memory configuration for the agent.
    memory_configuration: ?MemoryConfiguration,

    /// Specifies the orchestration strategy for the agent.
    orchestration_type: ?OrchestrationType,

    /// The time at which the agent was last prepared.
    prepared_at: ?i64,

    /// Contains configurations to override prompt templates in different parts of
    /// an agent sequence. For more information, see [Advanced
    /// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    prompt_override_configuration: ?PromptOverrideConfiguration,

    /// Contains recommended actions to take for the agent-related API that you
    /// invoked to succeed.
    recommended_actions: ?[]const []const u8,

    /// The time at which the agent was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_arn = "agentArn",
        .agent_collaboration = "agentCollaboration",
        .agent_id = "agentId",
        .agent_name = "agentName",
        .agent_resource_role_arn = "agentResourceRoleArn",
        .agent_status = "agentStatus",
        .agent_version = "agentVersion",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .custom_orchestration = "customOrchestration",
        .description = "description",
        .failure_reasons = "failureReasons",
        .foundation_model = "foundationModel",
        .guardrail_configuration = "guardrailConfiguration",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .instruction = "instruction",
        .memory_configuration = "memoryConfiguration",
        .orchestration_type = "orchestrationType",
        .prepared_at = "preparedAt",
        .prompt_override_configuration = "promptOverrideConfiguration",
        .recommended_actions = "recommendedActions",
        .updated_at = "updatedAt",
    };
};
