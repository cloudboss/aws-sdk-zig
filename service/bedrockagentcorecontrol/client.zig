const aws = @import("aws");
const std = @import("std");

const create_agent_runtime = @import("create_agent_runtime.zig");
const create_agent_runtime_endpoint = @import("create_agent_runtime_endpoint.zig");
const create_api_key_credential_provider = @import("create_api_key_credential_provider.zig");
const create_browser = @import("create_browser.zig");
const create_browser_profile = @import("create_browser_profile.zig");
const create_code_interpreter = @import("create_code_interpreter.zig");
const create_evaluator = @import("create_evaluator.zig");
const create_gateway = @import("create_gateway.zig");
const create_gateway_target = @import("create_gateway_target.zig");
const create_memory = @import("create_memory.zig");
const create_oauth_2_credential_provider = @import("create_oauth_2_credential_provider.zig");
const create_online_evaluation_config = @import("create_online_evaluation_config.zig");
const create_policy = @import("create_policy.zig");
const create_policy_engine = @import("create_policy_engine.zig");
const create_workload_identity = @import("create_workload_identity.zig");
const delete_agent_runtime = @import("delete_agent_runtime.zig");
const delete_agent_runtime_endpoint = @import("delete_agent_runtime_endpoint.zig");
const delete_api_key_credential_provider = @import("delete_api_key_credential_provider.zig");
const delete_browser = @import("delete_browser.zig");
const delete_browser_profile = @import("delete_browser_profile.zig");
const delete_code_interpreter = @import("delete_code_interpreter.zig");
const delete_evaluator = @import("delete_evaluator.zig");
const delete_gateway = @import("delete_gateway.zig");
const delete_gateway_target = @import("delete_gateway_target.zig");
const delete_memory = @import("delete_memory.zig");
const delete_oauth_2_credential_provider = @import("delete_oauth_2_credential_provider.zig");
const delete_online_evaluation_config = @import("delete_online_evaluation_config.zig");
const delete_policy = @import("delete_policy.zig");
const delete_policy_engine = @import("delete_policy_engine.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_workload_identity = @import("delete_workload_identity.zig");
const get_agent_runtime = @import("get_agent_runtime.zig");
const get_agent_runtime_endpoint = @import("get_agent_runtime_endpoint.zig");
const get_api_key_credential_provider = @import("get_api_key_credential_provider.zig");
const get_browser = @import("get_browser.zig");
const get_browser_profile = @import("get_browser_profile.zig");
const get_code_interpreter = @import("get_code_interpreter.zig");
const get_evaluator = @import("get_evaluator.zig");
const get_gateway = @import("get_gateway.zig");
const get_gateway_target = @import("get_gateway_target.zig");
const get_memory = @import("get_memory.zig");
const get_oauth_2_credential_provider = @import("get_oauth_2_credential_provider.zig");
const get_online_evaluation_config = @import("get_online_evaluation_config.zig");
const get_policy = @import("get_policy.zig");
const get_policy_engine = @import("get_policy_engine.zig");
const get_policy_generation = @import("get_policy_generation.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_token_vault = @import("get_token_vault.zig");
const get_workload_identity = @import("get_workload_identity.zig");
const list_agent_runtime_endpoints = @import("list_agent_runtime_endpoints.zig");
const list_agent_runtime_versions = @import("list_agent_runtime_versions.zig");
const list_agent_runtimes = @import("list_agent_runtimes.zig");
const list_api_key_credential_providers = @import("list_api_key_credential_providers.zig");
const list_browser_profiles = @import("list_browser_profiles.zig");
const list_browsers = @import("list_browsers.zig");
const list_code_interpreters = @import("list_code_interpreters.zig");
const list_evaluators = @import("list_evaluators.zig");
const list_gateway_targets = @import("list_gateway_targets.zig");
const list_gateways = @import("list_gateways.zig");
const list_memories = @import("list_memories.zig");
const list_oauth_2_credential_providers = @import("list_oauth_2_credential_providers.zig");
const list_online_evaluation_configs = @import("list_online_evaluation_configs.zig");
const list_policies = @import("list_policies.zig");
const list_policy_engines = @import("list_policy_engines.zig");
const list_policy_generation_assets = @import("list_policy_generation_assets.zig");
const list_policy_generations = @import("list_policy_generations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workload_identities = @import("list_workload_identities.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const set_token_vault_cmk = @import("set_token_vault_cmk.zig");
const start_policy_generation = @import("start_policy_generation.zig");
const synchronize_gateway_targets = @import("synchronize_gateway_targets.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent_runtime = @import("update_agent_runtime.zig");
const update_agent_runtime_endpoint = @import("update_agent_runtime_endpoint.zig");
const update_api_key_credential_provider = @import("update_api_key_credential_provider.zig");
const update_evaluator = @import("update_evaluator.zig");
const update_gateway = @import("update_gateway.zig");
const update_gateway_target = @import("update_gateway_target.zig");
const update_memory = @import("update_memory.zig");
const update_oauth_2_credential_provider = @import("update_oauth_2_credential_provider.zig");
const update_online_evaluation_config = @import("update_online_evaluation_config.zig");
const update_policy = @import("update_policy.zig");
const update_policy_engine = @import("update_policy_engine.zig");
const update_workload_identity = @import("update_workload_identity.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock AgentCore Control";

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

    /// Creates an Amazon Bedrock AgentCore Runtime.
    pub fn createAgentRuntime(self: *Self, allocator: std.mem.Allocator, input: create_agent_runtime.CreateAgentRuntimeInput, options: CallOptions) !create_agent_runtime.CreateAgentRuntimeOutput {
        return create_agent_runtime.execute(self, allocator, input, options);
    }

    /// Creates an AgentCore Runtime endpoint.
    pub fn createAgentRuntimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_agent_runtime_endpoint.CreateAgentRuntimeEndpointInput, options: CallOptions) !create_agent_runtime_endpoint.CreateAgentRuntimeEndpointOutput {
        return create_agent_runtime_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new API key credential provider.
    pub fn createApiKeyCredentialProvider(self: *Self, allocator: std.mem.Allocator, input: create_api_key_credential_provider.CreateApiKeyCredentialProviderInput, options: CallOptions) !create_api_key_credential_provider.CreateApiKeyCredentialProviderOutput {
        return create_api_key_credential_provider.execute(self, allocator, input, options);
    }

    /// Creates a custom browser.
    pub fn createBrowser(self: *Self, allocator: std.mem.Allocator, input: create_browser.CreateBrowserInput, options: CallOptions) !create_browser.CreateBrowserOutput {
        return create_browser.execute(self, allocator, input, options);
    }

    /// Creates a browser profile in Amazon Bedrock AgentCore. A browser profile
    /// stores persistent browser data such as cookies, local storage, session
    /// storage, and browsing history that can be saved from browser sessions and
    /// reused in subsequent sessions.
    pub fn createBrowserProfile(self: *Self, allocator: std.mem.Allocator, input: create_browser_profile.CreateBrowserProfileInput, options: CallOptions) !create_browser_profile.CreateBrowserProfileOutput {
        return create_browser_profile.execute(self, allocator, input, options);
    }

    /// Creates a custom code interpreter.
    pub fn createCodeInterpreter(self: *Self, allocator: std.mem.Allocator, input: create_code_interpreter.CreateCodeInterpreterInput, options: CallOptions) !create_code_interpreter.CreateCodeInterpreterOutput {
        return create_code_interpreter.execute(self, allocator, input, options);
    }

    /// Creates a custom evaluator for agent quality assessment. Custom evaluators
    /// use LLM-as-a-Judge configurations with user-defined prompts, rating scales,
    /// and model settings to evaluate agent performance at tool call, trace, or
    /// session levels.
    pub fn createEvaluator(self: *Self, allocator: std.mem.Allocator, input: create_evaluator.CreateEvaluatorInput, options: CallOptions) !create_evaluator.CreateEvaluatorOutput {
        return create_evaluator.execute(self, allocator, input, options);
    }

    /// Creates a gateway for Amazon Bedrock Agent. A gateway serves as an
    /// integration point between your agent and external services.
    ///
    /// If you specify `CUSTOM_JWT` as the `authorizerType`, you must provide an
    /// `authorizerConfiguration`.
    pub fn createGateway(self: *Self, allocator: std.mem.Allocator, input: create_gateway.CreateGatewayInput, options: CallOptions) !create_gateway.CreateGatewayOutput {
        return create_gateway.execute(self, allocator, input, options);
    }

    /// Creates a target for a gateway. A target defines an endpoint that the
    /// gateway can connect to.
    pub fn createGatewayTarget(self: *Self, allocator: std.mem.Allocator, input: create_gateway_target.CreateGatewayTargetInput, options: CallOptions) !create_gateway_target.CreateGatewayTargetOutput {
        return create_gateway_target.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Bedrock AgentCore Memory resource.
    pub fn createMemory(self: *Self, allocator: std.mem.Allocator, input: create_memory.CreateMemoryInput, options: CallOptions) !create_memory.CreateMemoryOutput {
        return create_memory.execute(self, allocator, input, options);
    }

    /// Creates a new OAuth2 credential provider.
    pub fn createOauth2CredentialProvider(self: *Self, allocator: std.mem.Allocator, input: create_oauth_2_credential_provider.CreateOauth2CredentialProviderInput, options: CallOptions) !create_oauth_2_credential_provider.CreateOauth2CredentialProviderOutput {
        return create_oauth_2_credential_provider.execute(self, allocator, input, options);
    }

    /// Creates an online evaluation configuration for continuous monitoring of
    /// agent performance. Online evaluation automatically samples live traffic from
    /// CloudWatch logs at specified rates and applies evaluators to assess agent
    /// quality in production.
    pub fn createOnlineEvaluationConfig(self: *Self, allocator: std.mem.Allocator, input: create_online_evaluation_config.CreateOnlineEvaluationConfigInput, options: CallOptions) !create_online_evaluation_config.CreateOnlineEvaluationConfigOutput {
        return create_online_evaluation_config.execute(self, allocator, input, options);
    }

    /// Creates a policy within the AgentCore Policy system. Policies provide
    /// real-time, deterministic control over agentic interactions with AgentCore
    /// Gateway. Using the Cedar policy language, you can define fine-grained
    /// policies that specify which interactions with Gateway tools are permitted
    /// based on input parameters and OAuth claims, ensuring agents operate within
    /// defined boundaries and business rules. The policy is validated during
    /// creation against the Cedar schema generated from the Gateway's tools' input
    /// schemas, which defines the available tools, their parameters, and expected
    /// data types. This is an asynchronous operation. Use the
    /// [GetPolicy](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_GetPolicy.html) operation to poll the `status` field to track completion.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: CallOptions) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Creates a new policy engine within the AgentCore Policy system. A policy
    /// engine is a collection of policies that evaluates and authorizes agent tool
    /// calls. When associated with Gateways (each Gateway can be associated with at
    /// most one policy engine, but multiple Gateways can be associated with the
    /// same engine), the policy engine intercepts all agent requests and determines
    /// whether to allow or deny each action based on the defined policies. This is
    /// an asynchronous operation. Use the
    /// [GetPolicyEngine](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_GetPolicyEngine.html) operation to poll the `status` field to track completion.
    pub fn createPolicyEngine(self: *Self, allocator: std.mem.Allocator, input: create_policy_engine.CreatePolicyEngineInput, options: CallOptions) !create_policy_engine.CreatePolicyEngineOutput {
        return create_policy_engine.execute(self, allocator, input, options);
    }

    /// Creates a new workload identity.
    pub fn createWorkloadIdentity(self: *Self, allocator: std.mem.Allocator, input: create_workload_identity.CreateWorkloadIdentityInput, options: CallOptions) !create_workload_identity.CreateWorkloadIdentityOutput {
        return create_workload_identity.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Bedrock AgentCore Runtime.
    pub fn deleteAgentRuntime(self: *Self, allocator: std.mem.Allocator, input: delete_agent_runtime.DeleteAgentRuntimeInput, options: CallOptions) !delete_agent_runtime.DeleteAgentRuntimeOutput {
        return delete_agent_runtime.execute(self, allocator, input, options);
    }

    /// Deletes an AAgentCore Runtime endpoint.
    pub fn deleteAgentRuntimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_agent_runtime_endpoint.DeleteAgentRuntimeEndpointInput, options: CallOptions) !delete_agent_runtime_endpoint.DeleteAgentRuntimeEndpointOutput {
        return delete_agent_runtime_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an API key credential provider.
    pub fn deleteApiKeyCredentialProvider(self: *Self, allocator: std.mem.Allocator, input: delete_api_key_credential_provider.DeleteApiKeyCredentialProviderInput, options: CallOptions) !delete_api_key_credential_provider.DeleteApiKeyCredentialProviderOutput {
        return delete_api_key_credential_provider.execute(self, allocator, input, options);
    }

    /// Deletes a custom browser.
    pub fn deleteBrowser(self: *Self, allocator: std.mem.Allocator, input: delete_browser.DeleteBrowserInput, options: CallOptions) !delete_browser.DeleteBrowserOutput {
        return delete_browser.execute(self, allocator, input, options);
    }

    /// Deletes a browser profile.
    pub fn deleteBrowserProfile(self: *Self, allocator: std.mem.Allocator, input: delete_browser_profile.DeleteBrowserProfileInput, options: CallOptions) !delete_browser_profile.DeleteBrowserProfileOutput {
        return delete_browser_profile.execute(self, allocator, input, options);
    }

    /// Deletes a custom code interpreter.
    pub fn deleteCodeInterpreter(self: *Self, allocator: std.mem.Allocator, input: delete_code_interpreter.DeleteCodeInterpreterInput, options: CallOptions) !delete_code_interpreter.DeleteCodeInterpreterOutput {
        return delete_code_interpreter.execute(self, allocator, input, options);
    }

    /// Deletes a custom evaluator. Builtin evaluators cannot be deleted. The
    /// evaluator must not be referenced by any active online evaluation
    /// configurations.
    pub fn deleteEvaluator(self: *Self, allocator: std.mem.Allocator, input: delete_evaluator.DeleteEvaluatorInput, options: CallOptions) !delete_evaluator.DeleteEvaluatorOutput {
        return delete_evaluator.execute(self, allocator, input, options);
    }

    /// Deletes a gateway.
    pub fn deleteGateway(self: *Self, allocator: std.mem.Allocator, input: delete_gateway.DeleteGatewayInput, options: CallOptions) !delete_gateway.DeleteGatewayOutput {
        return delete_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a gateway target.
    pub fn deleteGatewayTarget(self: *Self, allocator: std.mem.Allocator, input: delete_gateway_target.DeleteGatewayTargetInput, options: CallOptions) !delete_gateway_target.DeleteGatewayTargetOutput {
        return delete_gateway_target.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Bedrock AgentCore Memory resource.
    pub fn deleteMemory(self: *Self, allocator: std.mem.Allocator, input: delete_memory.DeleteMemoryInput, options: CallOptions) !delete_memory.DeleteMemoryOutput {
        return delete_memory.execute(self, allocator, input, options);
    }

    /// Deletes an OAuth2 credential provider.
    pub fn deleteOauth2CredentialProvider(self: *Self, allocator: std.mem.Allocator, input: delete_oauth_2_credential_provider.DeleteOauth2CredentialProviderInput, options: CallOptions) !delete_oauth_2_credential_provider.DeleteOauth2CredentialProviderOutput {
        return delete_oauth_2_credential_provider.execute(self, allocator, input, options);
    }

    /// Deletes an online evaluation configuration and stops any ongoing evaluation
    /// processes associated with it.
    pub fn deleteOnlineEvaluationConfig(self: *Self, allocator: std.mem.Allocator, input: delete_online_evaluation_config.DeleteOnlineEvaluationConfigInput, options: CallOptions) !delete_online_evaluation_config.DeleteOnlineEvaluationConfigOutput {
        return delete_online_evaluation_config.execute(self, allocator, input, options);
    }

    /// Deletes an existing policy from the AgentCore Policy system. Once deleted,
    /// the policy can no longer be used for agent behavior control and all
    /// references to it become invalid. This is an asynchronous operation. Use the
    /// `GetPolicy` operation to poll the `status` field to track completion.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes an existing policy engine from the AgentCore Policy system. The
    /// policy engine must not have any associated policies before deletion. Once
    /// deleted, the policy engine and all its configurations become unavailable for
    /// policy management and evaluation. This is an asynchronous operation. Use the
    /// `GetPolicyEngine` operation to poll the `status` field to track completion.
    pub fn deletePolicyEngine(self: *Self, allocator: std.mem.Allocator, input: delete_policy_engine.DeletePolicyEngineInput, options: CallOptions) !delete_policy_engine.DeletePolicyEngineOutput {
        return delete_policy_engine.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy for a specified resource.
    ///
    /// This feature is currently available only for AgentCore Runtime and Gateway.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a workload identity.
    pub fn deleteWorkloadIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_workload_identity.DeleteWorkloadIdentityInput, options: CallOptions) !delete_workload_identity.DeleteWorkloadIdentityOutput {
        return delete_workload_identity.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Bedrock AgentCore Runtime.
    pub fn getAgentRuntime(self: *Self, allocator: std.mem.Allocator, input: get_agent_runtime.GetAgentRuntimeInput, options: CallOptions) !get_agent_runtime.GetAgentRuntimeOutput {
        return get_agent_runtime.execute(self, allocator, input, options);
    }

    /// Gets information about an Amazon Secure AgentEndpoint.
    pub fn getAgentRuntimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_agent_runtime_endpoint.GetAgentRuntimeEndpointInput, options: CallOptions) !get_agent_runtime_endpoint.GetAgentRuntimeEndpointOutput {
        return get_agent_runtime_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves information about an API key credential provider.
    pub fn getApiKeyCredentialProvider(self: *Self, allocator: std.mem.Allocator, input: get_api_key_credential_provider.GetApiKeyCredentialProviderInput, options: CallOptions) !get_api_key_credential_provider.GetApiKeyCredentialProviderOutput {
        return get_api_key_credential_provider.execute(self, allocator, input, options);
    }

    /// Gets information about a custom browser.
    pub fn getBrowser(self: *Self, allocator: std.mem.Allocator, input: get_browser.GetBrowserInput, options: CallOptions) !get_browser.GetBrowserOutput {
        return get_browser.execute(self, allocator, input, options);
    }

    /// Gets information about a browser profile.
    pub fn getBrowserProfile(self: *Self, allocator: std.mem.Allocator, input: get_browser_profile.GetBrowserProfileInput, options: CallOptions) !get_browser_profile.GetBrowserProfileOutput {
        return get_browser_profile.execute(self, allocator, input, options);
    }

    /// Gets information about a custom code interpreter.
    pub fn getCodeInterpreter(self: *Self, allocator: std.mem.Allocator, input: get_code_interpreter.GetCodeInterpreterInput, options: CallOptions) !get_code_interpreter.GetCodeInterpreterOutput {
        return get_code_interpreter.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about an evaluator, including its
    /// configuration, status, and metadata. Works with both built-in and custom
    /// evaluators.
    pub fn getEvaluator(self: *Self, allocator: std.mem.Allocator, input: get_evaluator.GetEvaluatorInput, options: CallOptions) !get_evaluator.GetEvaluatorOutput {
        return get_evaluator.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific Gateway.
    pub fn getGateway(self: *Self, allocator: std.mem.Allocator, input: get_gateway.GetGatewayInput, options: CallOptions) !get_gateway.GetGatewayOutput {
        return get_gateway.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific gateway target.
    pub fn getGatewayTarget(self: *Self, allocator: std.mem.Allocator, input: get_gateway_target.GetGatewayTargetInput, options: CallOptions) !get_gateway_target.GetGatewayTargetOutput {
        return get_gateway_target.execute(self, allocator, input, options);
    }

    /// Retrieve an existing Amazon Bedrock AgentCore Memory resource.
    pub fn getMemory(self: *Self, allocator: std.mem.Allocator, input: get_memory.GetMemoryInput, options: CallOptions) !get_memory.GetMemoryOutput {
        return get_memory.execute(self, allocator, input, options);
    }

    /// Retrieves information about an OAuth2 credential provider.
    pub fn getOauth2CredentialProvider(self: *Self, allocator: std.mem.Allocator, input: get_oauth_2_credential_provider.GetOauth2CredentialProviderInput, options: CallOptions) !get_oauth_2_credential_provider.GetOauth2CredentialProviderOutput {
        return get_oauth_2_credential_provider.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about an online evaluation configuration,
    /// including its rules, data sources, evaluators, and execution status.
    pub fn getOnlineEvaluationConfig(self: *Self, allocator: std.mem.Allocator, input: get_online_evaluation_config.GetOnlineEvaluationConfigInput, options: CallOptions) !get_online_evaluation_config.GetOnlineEvaluationConfigOutput {
        return get_online_evaluation_config.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific policy within the AgentCore
    /// Policy system. This operation returns the complete policy definition,
    /// metadata, and current status, allowing administrators to review and manage
    /// policy configurations.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific policy engine within the
    /// AgentCore Policy system. This operation returns the complete policy engine
    /// configuration, metadata, and current status, allowing administrators to
    /// review and manage policy engine settings.
    pub fn getPolicyEngine(self: *Self, allocator: std.mem.Allocator, input: get_policy_engine.GetPolicyEngineInput, options: CallOptions) !get_policy_engine.GetPolicyEngineOutput {
        return get_policy_engine.execute(self, allocator, input, options);
    }

    /// Retrieves information about a policy generation request within the AgentCore
    /// Policy system. Policy generation converts natural language descriptions into
    /// Cedar policy statements using AI-powered translation, enabling non-technical
    /// users to create policies.
    pub fn getPolicyGeneration(self: *Self, allocator: std.mem.Allocator, input: get_policy_generation.GetPolicyGenerationInput, options: CallOptions) !get_policy_generation.GetPolicyGenerationOutput {
        return get_policy_generation.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy for a specified resource.
    ///
    /// This feature is currently available only for AgentCore Runtime and Gateway.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about a token vault.
    pub fn getTokenVault(self: *Self, allocator: std.mem.Allocator, input: get_token_vault.GetTokenVaultInput, options: CallOptions) !get_token_vault.GetTokenVaultOutput {
        return get_token_vault.execute(self, allocator, input, options);
    }

    /// Retrieves information about a workload identity.
    pub fn getWorkloadIdentity(self: *Self, allocator: std.mem.Allocator, input: get_workload_identity.GetWorkloadIdentityInput, options: CallOptions) !get_workload_identity.GetWorkloadIdentityOutput {
        return get_workload_identity.execute(self, allocator, input, options);
    }

    /// Lists all endpoints for a specific Amazon Secure Agent.
    pub fn listAgentRuntimeEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_agent_runtime_endpoints.ListAgentRuntimeEndpointsInput, options: CallOptions) !list_agent_runtime_endpoints.ListAgentRuntimeEndpointsOutput {
        return list_agent_runtime_endpoints.execute(self, allocator, input, options);
    }

    /// Lists all versions of a specific Amazon Secure Agent.
    pub fn listAgentRuntimeVersions(self: *Self, allocator: std.mem.Allocator, input: list_agent_runtime_versions.ListAgentRuntimeVersionsInput, options: CallOptions) !list_agent_runtime_versions.ListAgentRuntimeVersionsOutput {
        return list_agent_runtime_versions.execute(self, allocator, input, options);
    }

    /// Lists all Amazon Secure Agents in your account.
    pub fn listAgentRuntimes(self: *Self, allocator: std.mem.Allocator, input: list_agent_runtimes.ListAgentRuntimesInput, options: CallOptions) !list_agent_runtimes.ListAgentRuntimesOutput {
        return list_agent_runtimes.execute(self, allocator, input, options);
    }

    /// Lists all API key credential providers in your account.
    pub fn listApiKeyCredentialProviders(self: *Self, allocator: std.mem.Allocator, input: list_api_key_credential_providers.ListApiKeyCredentialProvidersInput, options: CallOptions) !list_api_key_credential_providers.ListApiKeyCredentialProvidersOutput {
        return list_api_key_credential_providers.execute(self, allocator, input, options);
    }

    /// Lists all browser profiles in your account.
    pub fn listBrowserProfiles(self: *Self, allocator: std.mem.Allocator, input: list_browser_profiles.ListBrowserProfilesInput, options: CallOptions) !list_browser_profiles.ListBrowserProfilesOutput {
        return list_browser_profiles.execute(self, allocator, input, options);
    }

    /// Lists all custom browsers in your account.
    pub fn listBrowsers(self: *Self, allocator: std.mem.Allocator, input: list_browsers.ListBrowsersInput, options: CallOptions) !list_browsers.ListBrowsersOutput {
        return list_browsers.execute(self, allocator, input, options);
    }

    /// Lists all custom code interpreters in your account.
    pub fn listCodeInterpreters(self: *Self, allocator: std.mem.Allocator, input: list_code_interpreters.ListCodeInterpretersInput, options: CallOptions) !list_code_interpreters.ListCodeInterpretersOutput {
        return list_code_interpreters.execute(self, allocator, input, options);
    }

    /// Lists all available evaluators, including both builtin evaluators provided
    /// by the service and custom evaluators created by the user.
    pub fn listEvaluators(self: *Self, allocator: std.mem.Allocator, input: list_evaluators.ListEvaluatorsInput, options: CallOptions) !list_evaluators.ListEvaluatorsOutput {
        return list_evaluators.execute(self, allocator, input, options);
    }

    /// Lists all targets for a specific gateway.
    pub fn listGatewayTargets(self: *Self, allocator: std.mem.Allocator, input: list_gateway_targets.ListGatewayTargetsInput, options: CallOptions) !list_gateway_targets.ListGatewayTargetsOutput {
        return list_gateway_targets.execute(self, allocator, input, options);
    }

    /// Lists all gateways in the account.
    pub fn listGateways(self: *Self, allocator: std.mem.Allocator, input: list_gateways.ListGatewaysInput, options: CallOptions) !list_gateways.ListGatewaysOutput {
        return list_gateways.execute(self, allocator, input, options);
    }

    /// Lists the available Amazon Bedrock AgentCore Memory resources in the current
    /// Amazon Web Services Region.
    pub fn listMemories(self: *Self, allocator: std.mem.Allocator, input: list_memories.ListMemoriesInput, options: CallOptions) !list_memories.ListMemoriesOutput {
        return list_memories.execute(self, allocator, input, options);
    }

    /// Lists all OAuth2 credential providers in your account.
    pub fn listOauth2CredentialProviders(self: *Self, allocator: std.mem.Allocator, input: list_oauth_2_credential_providers.ListOauth2CredentialProvidersInput, options: CallOptions) !list_oauth_2_credential_providers.ListOauth2CredentialProvidersOutput {
        return list_oauth_2_credential_providers.execute(self, allocator, input, options);
    }

    /// Lists all online evaluation configurations in the account, providing summary
    /// information about each configuration's status and settings.
    pub fn listOnlineEvaluationConfigs(self: *Self, allocator: std.mem.Allocator, input: list_online_evaluation_configs.ListOnlineEvaluationConfigsInput, options: CallOptions) !list_online_evaluation_configs.ListOnlineEvaluationConfigsOutput {
        return list_online_evaluation_configs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of policies within the AgentCore Policy engine. This
    /// operation supports pagination and filtering to help administrators manage
    /// and discover policies across policy engines. Results can be filtered by
    /// policy engine or resource associations.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Retrieves a list of policy engines within the AgentCore Policy system. This
    /// operation supports pagination to help administrators discover and manage
    /// policy engines across their account. Each policy engine serves as a
    /// container for related policies.
    pub fn listPolicyEngines(self: *Self, allocator: std.mem.Allocator, input: list_policy_engines.ListPolicyEnginesInput, options: CallOptions) !list_policy_engines.ListPolicyEnginesOutput {
        return list_policy_engines.execute(self, allocator, input, options);
    }

    /// Retrieves a list of generated policy assets from a policy generation request
    /// within the AgentCore Policy system. This operation returns the actual Cedar
    /// policies and related artifacts produced by the AI-powered policy generation
    /// process, allowing users to review and select from multiple generated policy
    /// options.
    pub fn listPolicyGenerationAssets(self: *Self, allocator: std.mem.Allocator, input: list_policy_generation_assets.ListPolicyGenerationAssetsInput, options: CallOptions) !list_policy_generation_assets.ListPolicyGenerationAssetsOutput {
        return list_policy_generation_assets.execute(self, allocator, input, options);
    }

    /// Retrieves a list of policy generation requests within the AgentCore Policy
    /// system. This operation supports pagination and filtering to help track and
    /// manage AI-powered policy generation operations.
    pub fn listPolicyGenerations(self: *Self, allocator: std.mem.Allocator, input: list_policy_generations.ListPolicyGenerationsInput, options: CallOptions) !list_policy_generations.ListPolicyGenerationsOutput {
        return list_policy_generations.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the specified resource.
    ///
    /// This feature is currently available only for AgentCore Runtime, Browser,
    /// Browser Profile, Code Interpreter tool, and Gateway.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all workload identities in your account.
    pub fn listWorkloadIdentities(self: *Self, allocator: std.mem.Allocator, input: list_workload_identities.ListWorkloadIdentitiesInput, options: CallOptions) !list_workload_identities.ListWorkloadIdentitiesOutput {
        return list_workload_identities.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource-based policy for a resource with the specified
    /// resourceArn.
    ///
    /// This feature is currently available only for AgentCore Runtime and Gateway.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Sets the customer master key (CMK) for a token vault.
    pub fn setTokenVaultCmk(self: *Self, allocator: std.mem.Allocator, input: set_token_vault_cmk.SetTokenVaultCMKInput, options: CallOptions) !set_token_vault_cmk.SetTokenVaultCMKOutput {
        return set_token_vault_cmk.execute(self, allocator, input, options);
    }

    /// Initiates the AI-powered generation of Cedar policies from natural language
    /// descriptions within the AgentCore Policy system. This feature enables both
    /// technical and non-technical users to create policies by describing their
    /// authorization requirements in plain English, which is then automatically
    /// translated into formal Cedar policy statements. The generation process
    /// analyzes the natural language input along with the Gateway's tool context to
    /// produce validated policy options. Generated policy assets are automatically
    /// deleted after 7 days, so you should review and create policies from the
    /// generated assets within this timeframe. Once created, policies are permanent
    /// and not subject to this expiration. Generated policies should be reviewed
    /// and tested in log-only mode before deploying to production. Use this when
    /// you want to describe policy intent naturally rather than learning Cedar
    /// syntax, though generated policies may require refinement for complex
    /// scenarios.
    pub fn startPolicyGeneration(self: *Self, allocator: std.mem.Allocator, input: start_policy_generation.StartPolicyGenerationInput, options: CallOptions) !start_policy_generation.StartPolicyGenerationOutput {
        return start_policy_generation.execute(self, allocator, input, options);
    }

    /// The gateway targets.
    pub fn synchronizeGatewayTargets(self: *Self, allocator: std.mem.Allocator, input: synchronize_gateway_targets.SynchronizeGatewayTargetsInput, options: CallOptions) !synchronize_gateway_targets.SynchronizeGatewayTargetsOutput {
        return synchronize_gateway_targets.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified resourceArn.
    /// If existing tags on a resource are not specified in the request parameters,
    /// they are not changed. When a resource is deleted, the tags associated with
    /// that resource are also deleted.
    ///
    /// This feature is currently available only for AgentCore Runtime, Browser,
    /// Browser Profile, Code Interpreter tool, and Gateway.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    ///
    /// This feature is currently available only for AgentCore Runtime, Browser,
    /// Browser Profile, Code Interpreter tool, and Gateway.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Secure Agent.
    pub fn updateAgentRuntime(self: *Self, allocator: std.mem.Allocator, input: update_agent_runtime.UpdateAgentRuntimeInput, options: CallOptions) !update_agent_runtime.UpdateAgentRuntimeOutput {
        return update_agent_runtime.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Bedrock AgentCore Runtime endpoint.
    pub fn updateAgentRuntimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_agent_runtime_endpoint.UpdateAgentRuntimeEndpointInput, options: CallOptions) !update_agent_runtime_endpoint.UpdateAgentRuntimeEndpointOutput {
        return update_agent_runtime_endpoint.execute(self, allocator, input, options);
    }

    /// Updates an existing API key credential provider.
    pub fn updateApiKeyCredentialProvider(self: *Self, allocator: std.mem.Allocator, input: update_api_key_credential_provider.UpdateApiKeyCredentialProviderInput, options: CallOptions) !update_api_key_credential_provider.UpdateApiKeyCredentialProviderOutput {
        return update_api_key_credential_provider.execute(self, allocator, input, options);
    }

    /// Updates a custom evaluator's configuration, description, or evaluation
    /// level. Built-in evaluators cannot be updated. The evaluator must not be
    /// locked for modification.
    pub fn updateEvaluator(self: *Self, allocator: std.mem.Allocator, input: update_evaluator.UpdateEvaluatorInput, options: CallOptions) !update_evaluator.UpdateEvaluatorOutput {
        return update_evaluator.execute(self, allocator, input, options);
    }

    /// Updates an existing gateway.
    pub fn updateGateway(self: *Self, allocator: std.mem.Allocator, input: update_gateway.UpdateGatewayInput, options: CallOptions) !update_gateway.UpdateGatewayOutput {
        return update_gateway.execute(self, allocator, input, options);
    }

    /// Updates an existing gateway target.
    pub fn updateGatewayTarget(self: *Self, allocator: std.mem.Allocator, input: update_gateway_target.UpdateGatewayTargetInput, options: CallOptions) !update_gateway_target.UpdateGatewayTargetOutput {
        return update_gateway_target.execute(self, allocator, input, options);
    }

    /// Update an Amazon Bedrock AgentCore Memory resource memory.
    pub fn updateMemory(self: *Self, allocator: std.mem.Allocator, input: update_memory.UpdateMemoryInput, options: CallOptions) !update_memory.UpdateMemoryOutput {
        return update_memory.execute(self, allocator, input, options);
    }

    /// Updates an existing OAuth2 credential provider.
    pub fn updateOauth2CredentialProvider(self: *Self, allocator: std.mem.Allocator, input: update_oauth_2_credential_provider.UpdateOauth2CredentialProviderInput, options: CallOptions) !update_oauth_2_credential_provider.UpdateOauth2CredentialProviderOutput {
        return update_oauth_2_credential_provider.execute(self, allocator, input, options);
    }

    /// Updates an online evaluation configuration's settings, including rules, data
    /// sources, evaluators, and execution status. Changes take effect immediately
    /// for ongoing evaluations.
    pub fn updateOnlineEvaluationConfig(self: *Self, allocator: std.mem.Allocator, input: update_online_evaluation_config.UpdateOnlineEvaluationConfigInput, options: CallOptions) !update_online_evaluation_config.UpdateOnlineEvaluationConfigOutput {
        return update_online_evaluation_config.execute(self, allocator, input, options);
    }

    /// Updates an existing policy within the AgentCore Policy system. This
    /// operation allows modification of the policy description and definition while
    /// maintaining the policy's identity. The updated policy is validated against
    /// the Cedar schema before being applied. This is an asynchronous operation.
    /// Use the `GetPolicy` operation to poll the `status` field to track
    /// completion.
    pub fn updatePolicy(self: *Self, allocator: std.mem.Allocator, input: update_policy.UpdatePolicyInput, options: CallOptions) !update_policy.UpdatePolicyOutput {
        return update_policy.execute(self, allocator, input, options);
    }

    /// Updates an existing policy engine within the AgentCore Policy system. This
    /// operation allows modification of the policy engine description while
    /// maintaining its identity. This is an asynchronous operation. Use the
    /// `GetPolicyEngine` operation to poll the `status` field to track completion.
    pub fn updatePolicyEngine(self: *Self, allocator: std.mem.Allocator, input: update_policy_engine.UpdatePolicyEngineInput, options: CallOptions) !update_policy_engine.UpdatePolicyEngineOutput {
        return update_policy_engine.execute(self, allocator, input, options);
    }

    /// Updates an existing workload identity.
    pub fn updateWorkloadIdentity(self: *Self, allocator: std.mem.Allocator, input: update_workload_identity.UpdateWorkloadIdentityInput, options: CallOptions) !update_workload_identity.UpdateWorkloadIdentityOutput {
        return update_workload_identity.execute(self, allocator, input, options);
    }

    pub fn listAgentRuntimeEndpointsPaginator(self: *Self, params: list_agent_runtime_endpoints.ListAgentRuntimeEndpointsInput) paginator.ListAgentRuntimeEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAgentRuntimeVersionsPaginator(self: *Self, params: list_agent_runtime_versions.ListAgentRuntimeVersionsInput) paginator.ListAgentRuntimeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAgentRuntimesPaginator(self: *Self, params: list_agent_runtimes.ListAgentRuntimesInput) paginator.ListAgentRuntimesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApiKeyCredentialProvidersPaginator(self: *Self, params: list_api_key_credential_providers.ListApiKeyCredentialProvidersInput) paginator.ListApiKeyCredentialProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBrowserProfilesPaginator(self: *Self, params: list_browser_profiles.ListBrowserProfilesInput) paginator.ListBrowserProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBrowsersPaginator(self: *Self, params: list_browsers.ListBrowsersInput) paginator.ListBrowsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCodeInterpretersPaginator(self: *Self, params: list_code_interpreters.ListCodeInterpretersInput) paginator.ListCodeInterpretersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEvaluatorsPaginator(self: *Self, params: list_evaluators.ListEvaluatorsInput) paginator.ListEvaluatorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGatewayTargetsPaginator(self: *Self, params: list_gateway_targets.ListGatewayTargetsInput) paginator.ListGatewayTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGatewaysPaginator(self: *Self, params: list_gateways.ListGatewaysInput) paginator.ListGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMemoriesPaginator(self: *Self, params: list_memories.ListMemoriesInput) paginator.ListMemoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOauth2CredentialProvidersPaginator(self: *Self, params: list_oauth_2_credential_providers.ListOauth2CredentialProvidersInput) paginator.ListOauth2CredentialProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOnlineEvaluationConfigsPaginator(self: *Self, params: list_online_evaluation_configs.ListOnlineEvaluationConfigsInput) paginator.ListOnlineEvaluationConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyEnginesPaginator(self: *Self, params: list_policy_engines.ListPolicyEnginesInput) paginator.ListPolicyEnginesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyGenerationAssetsPaginator(self: *Self, params: list_policy_generation_assets.ListPolicyGenerationAssetsInput) paginator.ListPolicyGenerationAssetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyGenerationsPaginator(self: *Self, params: list_policy_generations.ListPolicyGenerationsInput) paginator.ListPolicyGenerationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkloadIdentitiesPaginator(self: *Self, params: list_workload_identities.ListWorkloadIdentitiesInput) paginator.ListWorkloadIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilMemoryCreated(self: *Self, params: get_memory.GetMemoryInput) aws.waiter.WaiterError!void {
        var w = waiters.MemoryCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyActive(self: *Self, params: get_policy.GetPolicyInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyDeleted(self: *Self, params: get_policy.GetPolicyInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyEngineActive(self: *Self, params: get_policy_engine.GetPolicyEngineInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyEngineActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyEngineDeleted(self: *Self, params: get_policy_engine.GetPolicyEngineInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyEngineDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyGenerationCompleted(self: *Self, params: get_policy_generation.GetPolicyGenerationInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyGenerationCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
