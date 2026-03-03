const aws = @import("aws");

const AIAgentConfigurationData = @import("ai_agent_configuration_data.zig").AIAgentConfigurationData;
const AssistantCapabilityConfiguration = @import("assistant_capability_configuration.zig").AssistantCapabilityConfiguration;
const AssistantIntegrationConfiguration = @import("assistant_integration_configuration.zig").AssistantIntegrationConfiguration;
const OrchestratorConfigurationEntry = @import("orchestrator_configuration_entry.zig").OrchestratorConfigurationEntry;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const AssistantStatus = @import("assistant_status.zig").AssistantStatus;
const AssistantType = @import("assistant_type.zig").AssistantType;

/// Summary information about the assistant.
pub const AssistantSummary = struct {
    /// The configuration of the AI Agents (mapped by AI Agent Type to AI Agent
    /// version) that is set on the Amazon Q in Connect Assistant.
    ai_agent_configuration: ?[]const aws.map.MapEntry(AIAgentConfigurationData) = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// The configuration information for the Amazon Q in Connect assistant
    /// capability.
    capability_configuration: ?AssistantCapabilityConfiguration = null,

    /// The description of the assistant.
    description: ?[]const u8 = null,

    /// The configuration information for the Amazon Q in Connect assistant
    /// integration.
    integration_configuration: ?AssistantIntegrationConfiguration = null,

    /// The name of the assistant.
    name: []const u8,

    /// The list of orchestrator configurations for the assistant.
    orchestrator_configuration_list: ?[]const OrchestratorConfigurationEntry = null,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, `kms:Decrypt`, and `kms:GenerateDataKey*` permissions to
    /// the IAM identity using the key to invoke Amazon Q in Connect. To use Amazon
    /// Q in Connect with chat, the key policy must also allow `kms:Decrypt`,
    /// `kms:GenerateDataKey*`, and `kms:DescribeKey` permissions to the
    /// `connect.amazonaws.com` service principal.
    ///
    /// For more information about setting up a customer managed key for Amazon Q in
    /// Connect, see [Enable Amazon Q in Connect for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-q.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The status of the assistant.
    status: AssistantStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the assistant.
    @"type": AssistantType,

    pub const json_field_names = .{
        .ai_agent_configuration = "aiAgentConfiguration",
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .capability_configuration = "capabilityConfiguration",
        .description = "description",
        .integration_configuration = "integrationConfiguration",
        .name = "name",
        .orchestrator_configuration_list = "orchestratorConfigurationList",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
    };
};
