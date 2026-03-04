const aws = @import("aws");
const std = @import("std");

const associate_agent_collaborator = @import("associate_agent_collaborator.zig");
const associate_agent_knowledge_base = @import("associate_agent_knowledge_base.zig");
const create_agent = @import("create_agent.zig");
const create_agent_action_group = @import("create_agent_action_group.zig");
const create_agent_alias = @import("create_agent_alias.zig");
const create_data_source = @import("create_data_source.zig");
const create_flow = @import("create_flow.zig");
const create_flow_alias = @import("create_flow_alias.zig");
const create_flow_version = @import("create_flow_version.zig");
const create_knowledge_base = @import("create_knowledge_base.zig");
const create_prompt = @import("create_prompt.zig");
const create_prompt_version = @import("create_prompt_version.zig");
const delete_agent = @import("delete_agent.zig");
const delete_agent_action_group = @import("delete_agent_action_group.zig");
const delete_agent_alias = @import("delete_agent_alias.zig");
const delete_agent_version = @import("delete_agent_version.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_flow = @import("delete_flow.zig");
const delete_flow_alias = @import("delete_flow_alias.zig");
const delete_flow_version = @import("delete_flow_version.zig");
const delete_knowledge_base = @import("delete_knowledge_base.zig");
const delete_knowledge_base_documents = @import("delete_knowledge_base_documents.zig");
const delete_prompt = @import("delete_prompt.zig");
const disassociate_agent_collaborator = @import("disassociate_agent_collaborator.zig");
const disassociate_agent_knowledge_base = @import("disassociate_agent_knowledge_base.zig");
const get_agent = @import("get_agent.zig");
const get_agent_action_group = @import("get_agent_action_group.zig");
const get_agent_alias = @import("get_agent_alias.zig");
const get_agent_collaborator = @import("get_agent_collaborator.zig");
const get_agent_knowledge_base = @import("get_agent_knowledge_base.zig");
const get_agent_version = @import("get_agent_version.zig");
const get_data_source = @import("get_data_source.zig");
const get_flow = @import("get_flow.zig");
const get_flow_alias = @import("get_flow_alias.zig");
const get_flow_version = @import("get_flow_version.zig");
const get_ingestion_job = @import("get_ingestion_job.zig");
const get_knowledge_base = @import("get_knowledge_base.zig");
const get_knowledge_base_documents = @import("get_knowledge_base_documents.zig");
const get_prompt = @import("get_prompt.zig");
const ingest_knowledge_base_documents = @import("ingest_knowledge_base_documents.zig");
const list_agent_action_groups = @import("list_agent_action_groups.zig");
const list_agent_aliases = @import("list_agent_aliases.zig");
const list_agent_collaborators = @import("list_agent_collaborators.zig");
const list_agent_knowledge_bases = @import("list_agent_knowledge_bases.zig");
const list_agent_versions = @import("list_agent_versions.zig");
const list_agents = @import("list_agents.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_flow_aliases = @import("list_flow_aliases.zig");
const list_flow_versions = @import("list_flow_versions.zig");
const list_flows = @import("list_flows.zig");
const list_ingestion_jobs = @import("list_ingestion_jobs.zig");
const list_knowledge_base_documents = @import("list_knowledge_base_documents.zig");
const list_knowledge_bases = @import("list_knowledge_bases.zig");
const list_prompts = @import("list_prompts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const prepare_agent = @import("prepare_agent.zig");
const prepare_flow = @import("prepare_flow.zig");
const start_ingestion_job = @import("start_ingestion_job.zig");
const stop_ingestion_job = @import("stop_ingestion_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent = @import("update_agent.zig");
const update_agent_action_group = @import("update_agent_action_group.zig");
const update_agent_alias = @import("update_agent_alias.zig");
const update_agent_collaborator = @import("update_agent_collaborator.zig");
const update_agent_knowledge_base = @import("update_agent_knowledge_base.zig");
const update_data_source = @import("update_data_source.zig");
const update_flow = @import("update_flow.zig");
const update_flow_alias = @import("update_flow_alias.zig");
const update_knowledge_base = @import("update_knowledge_base.zig");
const update_prompt = @import("update_prompt.zig");
const validate_flow_definition = @import("validate_flow_definition.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock Agent";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Makes an agent a collaborator for another agent.
    pub fn associateAgentCollaborator(self: *Self, allocator: std.mem.Allocator, input: associate_agent_collaborator.AssociateAgentCollaboratorInput, options: CallOptions) !associate_agent_collaborator.AssociateAgentCollaboratorOutput {
        return associate_agent_collaborator.execute(self, allocator, input, options);
    }

    /// Associates a knowledge base with an agent. If a knowledge base is associated
    /// and its `indexState` is set to `Enabled`, the agent queries the knowledge
    /// base for information to augment its response to the user.
    pub fn associateAgentKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: associate_agent_knowledge_base.AssociateAgentKnowledgeBaseInput, options: CallOptions) !associate_agent_knowledge_base.AssociateAgentKnowledgeBaseOutput {
        return associate_agent_knowledge_base.execute(self, allocator, input, options);
    }

    /// Creates an agent that orchestrates interactions between foundation models,
    /// data sources, software applications, user conversations, and APIs to carry
    /// out tasks to help customers.
    ///
    /// * Specify the following fields for security purposes.
    ///
    /// * `agentResourceRoleArn` – The Amazon Resource Name (ARN) of the role with
    ///   permissions to invoke API operations on an agent.
    /// * (Optional) `customerEncryptionKeyArn` – The Amazon Resource Name (ARN) of
    ///   a KMS key to encrypt the creation of the agent.
    /// * (Optional) `idleSessionTTLinSeconds` – Specify the number of seconds for
    ///   which the agent should maintain session information. After this time
    ///   expires, the subsequent `InvokeAgent` request begins a new session.
    ///
    /// * To enable your agent to retain conversational context across multiple
    ///   sessions, include a `memoryConfiguration` object. For more information,
    ///   see [Configure
    ///   memory](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-configure-memory.html).
    /// * To override the default prompt behavior for agent orchestration and to use
    ///   advanced prompts, include a `promptOverrideConfiguration` object. For more
    ///   information, see [Advanced
    ///   prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    /// * If your agent fails to be created, the response returns a list of
    ///   `failureReasons` alongside a list of `recommendedActions` for you to
    ///   troubleshoot.
    /// * The agent instructions will not be honored if your agent has only one
    ///   knowledge base, uses default prompts, has no action group, and user input
    ///   is disabled.
    pub fn createAgent(self: *Self, allocator: std.mem.Allocator, input: create_agent.CreateAgentInput, options: CallOptions) !create_agent.CreateAgentOutput {
        return create_agent.execute(self, allocator, input, options);
    }

    /// Creates an action group for an agent. An action group represents the actions
    /// that an agent can carry out for the customer by defining the APIs that an
    /// agent can call and the logic for calling them.
    ///
    /// To allow your agent to request the user for additional information when
    /// trying to complete a task, add an action group with the
    /// `parentActionGroupSignature` field set to `AMAZON.UserInput`.
    ///
    /// To allow your agent to generate, run, and troubleshoot code when trying to
    /// complete a task, add an action group with the `parentActionGroupSignature`
    /// field set to `AMAZON.CodeInterpreter`.
    ///
    /// You must leave the `description`, `apiSchema`, and `actionGroupExecutor`
    /// fields blank for this action group. During orchestration, if your agent
    /// determines that it needs to invoke an API in an action group, but doesn't
    /// have enough information to complete the API request, it will invoke this
    /// action group instead and return an
    /// [Observation](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Observation.html) reprompting the user for more information.
    pub fn createAgentActionGroup(self: *Self, allocator: std.mem.Allocator, input: create_agent_action_group.CreateAgentActionGroupInput, options: CallOptions) !create_agent_action_group.CreateAgentActionGroupOutput {
        return create_agent_action_group.execute(self, allocator, input, options);
    }

    /// Creates an alias of an agent that can be used to deploy the agent.
    pub fn createAgentAlias(self: *Self, allocator: std.mem.Allocator, input: create_agent_alias.CreateAgentAliasInput, options: CallOptions) !create_agent_alias.CreateAgentAliasOutput {
        return create_agent_alias.execute(self, allocator, input, options);
    }

    /// Connects a knowledge base to a data source. You specify the configuration
    /// for the specific data source service in the `dataSourceConfiguration` field.
    ///
    /// You can't change the `chunkingConfiguration` after you create the data
    /// source connector.
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: CallOptions) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates a prompt flow that you can use to send an input through various
    /// steps to yield an output. Configure nodes, each of which corresponds to a
    /// step of the flow, and create connections between the nodes to create paths
    /// to different outputs. For more information, see [How it
    /// works](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-how-it-works.html) and [Create a flow in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-create.html) in the Amazon Bedrock User Guide.
    pub fn createFlow(self: *Self, allocator: std.mem.Allocator, input: create_flow.CreateFlowInput, options: CallOptions) !create_flow.CreateFlowOutput {
        return create_flow.execute(self, allocator, input, options);
    }

    /// Creates an alias of a flow for deployment. For more information, see [Deploy
    /// a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn createFlowAlias(self: *Self, allocator: std.mem.Allocator, input: create_flow_alias.CreateFlowAliasInput, options: CallOptions) !create_flow_alias.CreateFlowAliasOutput {
        return create_flow_alias.execute(self, allocator, input, options);
    }

    /// Creates a version of the flow that you can deploy. For more information, see
    /// [Deploy a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn createFlowVersion(self: *Self, allocator: std.mem.Allocator, input: create_flow_version.CreateFlowVersionInput, options: CallOptions) !create_flow_version.CreateFlowVersionOutput {
        return create_flow_version.execute(self, allocator, input, options);
    }

    /// Creates a knowledge base. A knowledge base contains your data sources so
    /// that Large Language Models (LLMs) can use your data. To create a knowledge
    /// base, you must first set up your data sources and configure a supported
    /// vector store. For more information, see [Set up a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/knowlege-base-prereq.html).
    ///
    /// If you prefer to let Amazon Bedrock create and manage a vector store for you
    /// in Amazon OpenSearch Service, use the console. For more information, see
    /// [Create a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-create).
    ///
    /// * Provide the `name` and an optional `description`.
    /// * Provide the Amazon Resource Name (ARN) with permissions to create a
    ///   knowledge base in the `roleArn` field.
    /// * Provide the embedding model to use in the `embeddingModelArn` field in the
    ///   `knowledgeBaseConfiguration` object.
    /// * Provide the configuration for your vector store in the
    ///   `storageConfiguration` object.
    ///
    /// * For an Amazon OpenSearch Service database, use the
    ///   `opensearchServerlessConfiguration` object. For more information, see
    ///   [Create a vector store in Amazon OpenSearch
    ///   Service](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-oss.html).
    /// * For an Amazon Aurora database, use the `RdsConfiguration` object. For more
    ///   information, see [Create a vector store in Amazon
    ///   Aurora](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-rds.html).
    /// * For a Pinecone database, use the `pineconeConfiguration` object. For more
    ///   information, see [Create a vector store in
    ///   Pinecone](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-pinecone.html).
    /// * For a Redis Enterprise Cloud database, use the
    ///   `redisEnterpriseCloudConfiguration` object. For more information, see
    ///   [Create a vector store in Redis Enterprise
    ///   Cloud](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-redis.html).
    pub fn createKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: create_knowledge_base.CreateKnowledgeBaseInput, options: CallOptions) !create_knowledge_base.CreateKnowledgeBaseOutput {
        return create_knowledge_base.execute(self, allocator, input, options);
    }

    /// Creates a prompt in your prompt library that you can add to a flow. For more
    /// information, see [Prompt management in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management.html), [Create a prompt using Prompt management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html) and [Prompt flows in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows.html) in the Amazon Bedrock User Guide.
    pub fn createPrompt(self: *Self, allocator: std.mem.Allocator, input: create_prompt.CreatePromptInput, options: CallOptions) !create_prompt.CreatePromptOutput {
        return create_prompt.execute(self, allocator, input, options);
    }

    /// Creates a static snapshot of your prompt that can be deployed to production.
    /// For more information, see [Deploy prompts using Prompt management by
    /// creating
    /// versions](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-deploy.html) in the Amazon Bedrock User Guide.
    pub fn createPromptVersion(self: *Self, allocator: std.mem.Allocator, input: create_prompt_version.CreatePromptVersionInput, options: CallOptions) !create_prompt_version.CreatePromptVersionOutput {
        return create_prompt_version.execute(self, allocator, input, options);
    }

    /// Deletes an agent.
    pub fn deleteAgent(self: *Self, allocator: std.mem.Allocator, input: delete_agent.DeleteAgentInput, options: CallOptions) !delete_agent.DeleteAgentOutput {
        return delete_agent.execute(self, allocator, input, options);
    }

    /// Deletes an action group in an agent.
    pub fn deleteAgentActionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_agent_action_group.DeleteAgentActionGroupInput, options: CallOptions) !delete_agent_action_group.DeleteAgentActionGroupOutput {
        return delete_agent_action_group.execute(self, allocator, input, options);
    }

    /// Deletes an alias of an agent.
    pub fn deleteAgentAlias(self: *Self, allocator: std.mem.Allocator, input: delete_agent_alias.DeleteAgentAliasInput, options: CallOptions) !delete_agent_alias.DeleteAgentAliasOutput {
        return delete_agent_alias.execute(self, allocator, input, options);
    }

    /// Deletes a version of an agent.
    pub fn deleteAgentVersion(self: *Self, allocator: std.mem.Allocator, input: delete_agent_version.DeleteAgentVersionInput, options: CallOptions) !delete_agent_version.DeleteAgentVersionOutput {
        return delete_agent_version.execute(self, allocator, input, options);
    }

    /// Deletes a data source from a knowledge base.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: CallOptions) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a flow.
    pub fn deleteFlow(self: *Self, allocator: std.mem.Allocator, input: delete_flow.DeleteFlowInput, options: CallOptions) !delete_flow.DeleteFlowOutput {
        return delete_flow.execute(self, allocator, input, options);
    }

    /// Deletes an alias of a flow.
    pub fn deleteFlowAlias(self: *Self, allocator: std.mem.Allocator, input: delete_flow_alias.DeleteFlowAliasInput, options: CallOptions) !delete_flow_alias.DeleteFlowAliasOutput {
        return delete_flow_alias.execute(self, allocator, input, options);
    }

    /// Deletes a version of a flow.
    pub fn deleteFlowVersion(self: *Self, allocator: std.mem.Allocator, input: delete_flow_version.DeleteFlowVersionInput, options: CallOptions) !delete_flow_version.DeleteFlowVersionOutput {
        return delete_flow_version.execute(self, allocator, input, options);
    }

    /// Deletes a knowledge base. Before deleting a knowledge base, you should
    /// disassociate the knowledge base from any agents that it is associated with
    /// by making a
    /// [DisassociateAgentKnowledgeBase](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_DisassociateAgentKnowledgeBase.html) request.
    pub fn deleteKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: delete_knowledge_base.DeleteKnowledgeBaseInput, options: CallOptions) !delete_knowledge_base.DeleteKnowledgeBaseOutput {
        return delete_knowledge_base.execute(self, allocator, input, options);
    }

    /// Deletes documents from a data source and syncs the changes to the knowledge
    /// base that is connected to it. For more information, see [Ingest changes
    /// directly into a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-direct-ingestion.html) in the Amazon Bedrock User Guide.
    pub fn deleteKnowledgeBaseDocuments(self: *Self, allocator: std.mem.Allocator, input: delete_knowledge_base_documents.DeleteKnowledgeBaseDocumentsInput, options: CallOptions) !delete_knowledge_base_documents.DeleteKnowledgeBaseDocumentsOutput {
        return delete_knowledge_base_documents.execute(self, allocator, input, options);
    }

    /// Deletes a prompt or a version of it, depending on whether you include the
    /// `promptVersion` field or not. For more information, see [Delete prompts from
    /// the Prompt management
    /// tool](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-manage.html#prompt-management-delete.html) and [Delete a version of a prompt from the Prompt management tool](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-deploy.html#prompt-management-versions-delete.html) in the Amazon Bedrock User Guide.
    pub fn deletePrompt(self: *Self, allocator: std.mem.Allocator, input: delete_prompt.DeletePromptInput, options: CallOptions) !delete_prompt.DeletePromptOutput {
        return delete_prompt.execute(self, allocator, input, options);
    }

    /// Disassociates an agent collaborator.
    pub fn disassociateAgentCollaborator(self: *Self, allocator: std.mem.Allocator, input: disassociate_agent_collaborator.DisassociateAgentCollaboratorInput, options: CallOptions) !disassociate_agent_collaborator.DisassociateAgentCollaboratorOutput {
        return disassociate_agent_collaborator.execute(self, allocator, input, options);
    }

    /// Disassociates a knowledge base from an agent.
    pub fn disassociateAgentKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: disassociate_agent_knowledge_base.DisassociateAgentKnowledgeBaseInput, options: CallOptions) !disassociate_agent_knowledge_base.DisassociateAgentKnowledgeBaseOutput {
        return disassociate_agent_knowledge_base.execute(self, allocator, input, options);
    }

    /// Gets information about an agent.
    pub fn getAgent(self: *Self, allocator: std.mem.Allocator, input: get_agent.GetAgentInput, options: CallOptions) !get_agent.GetAgentOutput {
        return get_agent.execute(self, allocator, input, options);
    }

    /// Gets information about an action group for an agent.
    pub fn getAgentActionGroup(self: *Self, allocator: std.mem.Allocator, input: get_agent_action_group.GetAgentActionGroupInput, options: CallOptions) !get_agent_action_group.GetAgentActionGroupOutput {
        return get_agent_action_group.execute(self, allocator, input, options);
    }

    /// Gets information about an alias of an agent.
    pub fn getAgentAlias(self: *Self, allocator: std.mem.Allocator, input: get_agent_alias.GetAgentAliasInput, options: CallOptions) !get_agent_alias.GetAgentAliasOutput {
        return get_agent_alias.execute(self, allocator, input, options);
    }

    /// Retrieves information about an agent's collaborator.
    pub fn getAgentCollaborator(self: *Self, allocator: std.mem.Allocator, input: get_agent_collaborator.GetAgentCollaboratorInput, options: CallOptions) !get_agent_collaborator.GetAgentCollaboratorOutput {
        return get_agent_collaborator.execute(self, allocator, input, options);
    }

    /// Gets information about a knowledge base associated with an agent.
    pub fn getAgentKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: get_agent_knowledge_base.GetAgentKnowledgeBaseInput, options: CallOptions) !get_agent_knowledge_base.GetAgentKnowledgeBaseOutput {
        return get_agent_knowledge_base.execute(self, allocator, input, options);
    }

    /// Gets details about a version of an agent.
    pub fn getAgentVersion(self: *Self, allocator: std.mem.Allocator, input: get_agent_version.GetAgentVersionInput, options: CallOptions) !get_agent_version.GetAgentVersionOutput {
        return get_agent_version.execute(self, allocator, input, options);
    }

    /// Gets information about a data source.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: CallOptions) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Retrieves information about a flow. For more information, see [Manage a flow
    /// in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-manage.html) in the Amazon Bedrock User Guide.
    pub fn getFlow(self: *Self, allocator: std.mem.Allocator, input: get_flow.GetFlowInput, options: CallOptions) !get_flow.GetFlowOutput {
        return get_flow.execute(self, allocator, input, options);
    }

    /// Retrieves information about a flow. For more information, see [Deploy a flow
    /// in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn getFlowAlias(self: *Self, allocator: std.mem.Allocator, input: get_flow_alias.GetFlowAliasInput, options: CallOptions) !get_flow_alias.GetFlowAliasOutput {
        return get_flow_alias.execute(self, allocator, input, options);
    }

    /// Retrieves information about a version of a flow. For more information, see
    /// [Deploy a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn getFlowVersion(self: *Self, allocator: std.mem.Allocator, input: get_flow_version.GetFlowVersionInput, options: CallOptions) !get_flow_version.GetFlowVersionOutput {
        return get_flow_version.execute(self, allocator, input, options);
    }

    /// Gets information about a data ingestion job. Data sources are ingested into
    /// your knowledge base so that Large Language Models (LLMs) can use your data.
    pub fn getIngestionJob(self: *Self, allocator: std.mem.Allocator, input: get_ingestion_job.GetIngestionJobInput, options: CallOptions) !get_ingestion_job.GetIngestionJobOutput {
        return get_ingestion_job.execute(self, allocator, input, options);
    }

    /// Gets information about a knowledge base.
    pub fn getKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: get_knowledge_base.GetKnowledgeBaseInput, options: CallOptions) !get_knowledge_base.GetKnowledgeBaseOutput {
        return get_knowledge_base.execute(self, allocator, input, options);
    }

    /// Retrieves specific documents from a data source that is connected to a
    /// knowledge base. For more information, see [Ingest changes directly into a
    /// knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-direct-ingestion.html) in the Amazon Bedrock User Guide.
    pub fn getKnowledgeBaseDocuments(self: *Self, allocator: std.mem.Allocator, input: get_knowledge_base_documents.GetKnowledgeBaseDocumentsInput, options: CallOptions) !get_knowledge_base_documents.GetKnowledgeBaseDocumentsOutput {
        return get_knowledge_base_documents.execute(self, allocator, input, options);
    }

    /// Retrieves information about the working draft (`DRAFT` version) of a prompt
    /// or a version of it, depending on whether you include the `promptVersion`
    /// field or not. For more information, see [View information about prompts
    /// using Prompt
    /// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-manage.html#prompt-management-view.html) and [View information about a version of your prompt](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-deploy.html#prompt-management-versions-view.html) in the Amazon Bedrock User Guide.
    pub fn getPrompt(self: *Self, allocator: std.mem.Allocator, input: get_prompt.GetPromptInput, options: CallOptions) !get_prompt.GetPromptOutput {
        return get_prompt.execute(self, allocator, input, options);
    }

    /// Ingests documents directly into the knowledge base that is connected to the
    /// data source. The `dataSourceType` specified in the content for each document
    /// must match the type of the data source that you specify in the header. For
    /// more information, see [Ingest changes directly into a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-direct-ingestion.html) in the Amazon Bedrock User Guide.
    pub fn ingestKnowledgeBaseDocuments(self: *Self, allocator: std.mem.Allocator, input: ingest_knowledge_base_documents.IngestKnowledgeBaseDocumentsInput, options: CallOptions) !ingest_knowledge_base_documents.IngestKnowledgeBaseDocumentsOutput {
        return ingest_knowledge_base_documents.execute(self, allocator, input, options);
    }

    /// Lists the action groups for an agent and information about each one.
    pub fn listAgentActionGroups(self: *Self, allocator: std.mem.Allocator, input: list_agent_action_groups.ListAgentActionGroupsInput, options: CallOptions) !list_agent_action_groups.ListAgentActionGroupsOutput {
        return list_agent_action_groups.execute(self, allocator, input, options);
    }

    /// Lists the aliases of an agent and information about each one.
    pub fn listAgentAliases(self: *Self, allocator: std.mem.Allocator, input: list_agent_aliases.ListAgentAliasesInput, options: CallOptions) !list_agent_aliases.ListAgentAliasesOutput {
        return list_agent_aliases.execute(self, allocator, input, options);
    }

    /// Retrieve a list of an agent's collaborators.
    pub fn listAgentCollaborators(self: *Self, allocator: std.mem.Allocator, input: list_agent_collaborators.ListAgentCollaboratorsInput, options: CallOptions) !list_agent_collaborators.ListAgentCollaboratorsOutput {
        return list_agent_collaborators.execute(self, allocator, input, options);
    }

    /// Lists knowledge bases associated with an agent and information about each
    /// one.
    pub fn listAgentKnowledgeBases(self: *Self, allocator: std.mem.Allocator, input: list_agent_knowledge_bases.ListAgentKnowledgeBasesInput, options: CallOptions) !list_agent_knowledge_bases.ListAgentKnowledgeBasesOutput {
        return list_agent_knowledge_bases.execute(self, allocator, input, options);
    }

    /// Lists the versions of an agent and information about each version.
    pub fn listAgentVersions(self: *Self, allocator: std.mem.Allocator, input: list_agent_versions.ListAgentVersionsInput, options: CallOptions) !list_agent_versions.ListAgentVersionsOutput {
        return list_agent_versions.execute(self, allocator, input, options);
    }

    /// Lists the agents belonging to an account and information about each agent.
    pub fn listAgents(self: *Self, allocator: std.mem.Allocator, input: list_agents.ListAgentsInput, options: CallOptions) !list_agents.ListAgentsOutput {
        return list_agents.execute(self, allocator, input, options);
    }

    /// Lists the data sources in a knowledge base and information about each one.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: CallOptions) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Returns a list of aliases for a flow.
    pub fn listFlowAliases(self: *Self, allocator: std.mem.Allocator, input: list_flow_aliases.ListFlowAliasesInput, options: CallOptions) !list_flow_aliases.ListFlowAliasesOutput {
        return list_flow_aliases.execute(self, allocator, input, options);
    }

    /// Returns a list of information about each flow. For more information, see
    /// [Deploy a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn listFlowVersions(self: *Self, allocator: std.mem.Allocator, input: list_flow_versions.ListFlowVersionsInput, options: CallOptions) !list_flow_versions.ListFlowVersionsOutput {
        return list_flow_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of flows and information about each flow. For more
    /// information, see [Manage a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-manage.html) in the Amazon Bedrock User Guide.
    pub fn listFlows(self: *Self, allocator: std.mem.Allocator, input: list_flows.ListFlowsInput, options: CallOptions) !list_flows.ListFlowsOutput {
        return list_flows.execute(self, allocator, input, options);
    }

    /// Lists the data ingestion jobs for a data source. The list also includes
    /// information about each job.
    pub fn listIngestionJobs(self: *Self, allocator: std.mem.Allocator, input: list_ingestion_jobs.ListIngestionJobsInput, options: CallOptions) !list_ingestion_jobs.ListIngestionJobsOutput {
        return list_ingestion_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves all the documents contained in a data source that is connected to
    /// a knowledge base. For more information, see [Ingest changes directly into a
    /// knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-direct-ingestion.html) in the Amazon Bedrock User Guide.
    pub fn listKnowledgeBaseDocuments(self: *Self, allocator: std.mem.Allocator, input: list_knowledge_base_documents.ListKnowledgeBaseDocumentsInput, options: CallOptions) !list_knowledge_base_documents.ListKnowledgeBaseDocumentsOutput {
        return list_knowledge_base_documents.execute(self, allocator, input, options);
    }

    /// Lists the knowledge bases in an account. The list also includesinformation
    /// about each knowledge base.
    pub fn listKnowledgeBases(self: *Self, allocator: std.mem.Allocator, input: list_knowledge_bases.ListKnowledgeBasesInput, options: CallOptions) !list_knowledge_bases.ListKnowledgeBasesOutput {
        return list_knowledge_bases.execute(self, allocator, input, options);
    }

    /// Returns either information about the working draft (`DRAFT` version) of each
    /// prompt in an account, or information about of all versions of a prompt,
    /// depending on whether you include the `promptIdentifier` field or not. For
    /// more information, see [View information about prompts using Prompt
    /// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-manage.html#prompt-management-view.html) in the Amazon Bedrock User Guide.
    pub fn listPrompts(self: *Self, allocator: std.mem.Allocator, input: list_prompts.ListPromptsInput, options: CallOptions) !list_prompts.ListPromptsOutput {
        return list_prompts.execute(self, allocator, input, options);
    }

    /// List all the tags for the resource you specify.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a `DRAFT` version of the agent that can be used for internal
    /// testing.
    pub fn prepareAgent(self: *Self, allocator: std.mem.Allocator, input: prepare_agent.PrepareAgentInput, options: CallOptions) !prepare_agent.PrepareAgentOutput {
        return prepare_agent.execute(self, allocator, input, options);
    }

    /// Prepares the `DRAFT` version of a flow so that it can be invoked. For more
    /// information, see [Test a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-test.html) in the Amazon Bedrock User Guide.
    pub fn prepareFlow(self: *Self, allocator: std.mem.Allocator, input: prepare_flow.PrepareFlowInput, options: CallOptions) !prepare_flow.PrepareFlowOutput {
        return prepare_flow.execute(self, allocator, input, options);
    }

    /// Begins a data ingestion job. Data sources are ingested into your knowledge
    /// base so that Large Language Models (LLMs) can use your data.
    pub fn startIngestionJob(self: *Self, allocator: std.mem.Allocator, input: start_ingestion_job.StartIngestionJobInput, options: CallOptions) !start_ingestion_job.StartIngestionJobOutput {
        return start_ingestion_job.execute(self, allocator, input, options);
    }

    /// Stops a currently running data ingestion job. You can send a
    /// `StartIngestionJob` request again to ingest the rest of your data when you
    /// are ready.
    pub fn stopIngestionJob(self: *Self, allocator: std.mem.Allocator, input: stop_ingestion_job.StopIngestionJobInput, options: CallOptions) !stop_ingestion_job.StopIngestionJobOutput {
        return stop_ingestion_job.execute(self, allocator, input, options);
    }

    /// Associate tags with a resource. For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the Amazon Bedrock User Guide.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an agent.
    pub fn updateAgent(self: *Self, allocator: std.mem.Allocator, input: update_agent.UpdateAgentInput, options: CallOptions) !update_agent.UpdateAgentOutput {
        return update_agent.execute(self, allocator, input, options);
    }

    /// Updates the configuration for an action group for an agent.
    pub fn updateAgentActionGroup(self: *Self, allocator: std.mem.Allocator, input: update_agent_action_group.UpdateAgentActionGroupInput, options: CallOptions) !update_agent_action_group.UpdateAgentActionGroupOutput {
        return update_agent_action_group.execute(self, allocator, input, options);
    }

    /// Updates configurations for an alias of an agent.
    pub fn updateAgentAlias(self: *Self, allocator: std.mem.Allocator, input: update_agent_alias.UpdateAgentAliasInput, options: CallOptions) !update_agent_alias.UpdateAgentAliasOutput {
        return update_agent_alias.execute(self, allocator, input, options);
    }

    /// Updates an agent's collaborator.
    pub fn updateAgentCollaborator(self: *Self, allocator: std.mem.Allocator, input: update_agent_collaborator.UpdateAgentCollaboratorInput, options: CallOptions) !update_agent_collaborator.UpdateAgentCollaboratorOutput {
        return update_agent_collaborator.execute(self, allocator, input, options);
    }

    /// Updates the configuration for a knowledge base that has been associated with
    /// an agent.
    pub fn updateAgentKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: update_agent_knowledge_base.UpdateAgentKnowledgeBaseInput, options: CallOptions) !update_agent_knowledge_base.UpdateAgentKnowledgeBaseOutput {
        return update_agent_knowledge_base.execute(self, allocator, input, options);
    }

    /// Updates the configurations for a data source connector.
    ///
    /// You can't change the `chunkingConfiguration` after you create the data
    /// source connector. Specify the existing `chunkingConfiguration`.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: CallOptions) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Modifies a flow. Include both fields that you want to keep and fields that
    /// you want to change. For more information, see [How it
    /// works](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-how-it-works.html) and [Create a flow in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-create.html) in the Amazon Bedrock User Guide.
    pub fn updateFlow(self: *Self, allocator: std.mem.Allocator, input: update_flow.UpdateFlowInput, options: CallOptions) !update_flow.UpdateFlowOutput {
        return update_flow.execute(self, allocator, input, options);
    }

    /// Modifies the alias of a flow. Include both fields that you want to keep and
    /// ones that you want to change. For more information, see [Deploy a flow in
    /// Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-deploy.html) in the Amazon Bedrock User Guide.
    pub fn updateFlowAlias(self: *Self, allocator: std.mem.Allocator, input: update_flow_alias.UpdateFlowAliasInput, options: CallOptions) !update_flow_alias.UpdateFlowAliasOutput {
        return update_flow_alias.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a knowledge base with the fields that you
    /// specify. Because all fields will be overwritten, you must include the same
    /// values for fields that you want to keep the same.
    ///
    /// You can change the following fields:
    ///
    /// * `name`
    /// * `description`
    /// * `roleArn`
    ///
    /// You can't change the `knowledgeBaseConfiguration` or `storageConfiguration`
    /// fields, so you must specify the same configurations as when you created the
    /// knowledge base. You can send a
    /// [GetKnowledgeBase](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetKnowledgeBase.html) request and copy the same configurations.
    pub fn updateKnowledgeBase(self: *Self, allocator: std.mem.Allocator, input: update_knowledge_base.UpdateKnowledgeBaseInput, options: CallOptions) !update_knowledge_base.UpdateKnowledgeBaseOutput {
        return update_knowledge_base.execute(self, allocator, input, options);
    }

    /// Modifies a prompt in your prompt library. Include both fields that you want
    /// to keep and fields that you want to replace. For more information, see
    /// [Prompt management in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management.html) and [Edit prompts in your prompt library](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-manage.html#prompt-management-edit) in the Amazon Bedrock User Guide.
    pub fn updatePrompt(self: *Self, allocator: std.mem.Allocator, input: update_prompt.UpdatePromptInput, options: CallOptions) !update_prompt.UpdatePromptOutput {
        return update_prompt.execute(self, allocator, input, options);
    }

    /// Validates the definition of a flow.
    pub fn validateFlowDefinition(self: *Self, allocator: std.mem.Allocator, input: validate_flow_definition.ValidateFlowDefinitionInput, options: CallOptions) !validate_flow_definition.ValidateFlowDefinitionOutput {
        return validate_flow_definition.execute(self, allocator, input, options);
    }

    pub fn listAgentActionGroupsPaginator(self: *Self, params: list_agent_action_groups.ListAgentActionGroupsInput) paginator.ListAgentActionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentAliasesPaginator(self: *Self, params: list_agent_aliases.ListAgentAliasesInput) paginator.ListAgentAliasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentCollaboratorsPaginator(self: *Self, params: list_agent_collaborators.ListAgentCollaboratorsInput) paginator.ListAgentCollaboratorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentKnowledgeBasesPaginator(self: *Self, params: list_agent_knowledge_bases.ListAgentKnowledgeBasesInput) paginator.ListAgentKnowledgeBasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentVersionsPaginator(self: *Self, params: list_agent_versions.ListAgentVersionsInput) paginator.ListAgentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentsPaginator(self: *Self, params: list_agents.ListAgentsInput) paginator.ListAgentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataSourcesPaginator(self: *Self, params: list_data_sources.ListDataSourcesInput) paginator.ListDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowAliasesPaginator(self: *Self, params: list_flow_aliases.ListFlowAliasesInput) paginator.ListFlowAliasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowVersionsPaginator(self: *Self, params: list_flow_versions.ListFlowVersionsInput) paginator.ListFlowVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowsPaginator(self: *Self, params: list_flows.ListFlowsInput) paginator.ListFlowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIngestionJobsPaginator(self: *Self, params: list_ingestion_jobs.ListIngestionJobsInput) paginator.ListIngestionJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKnowledgeBaseDocumentsPaginator(self: *Self, params: list_knowledge_base_documents.ListKnowledgeBaseDocumentsInput) paginator.ListKnowledgeBaseDocumentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKnowledgeBasesPaginator(self: *Self, params: list_knowledge_bases.ListKnowledgeBasesInput) paginator.ListKnowledgeBasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPromptsPaginator(self: *Self, params: list_prompts.ListPromptsInput) paginator.ListPromptsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
