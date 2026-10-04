const aws = @import("aws");

const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const HarnessEnvironmentProvider = @import("harness_environment_provider.zig").HarnessEnvironmentProvider;
const HarnessEnvironmentArtifact = @import("harness_environment_artifact.zig").HarnessEnvironmentArtifact;
const HarnessHook = @import("harness_hook.zig").HarnessHook;
const HarnessMemoryConfiguration = @import("harness_memory_configuration.zig").HarnessMemoryConfiguration;
const HarnessModelConfiguration = @import("harness_model_configuration.zig").HarnessModelConfiguration;
const HarnessSkill = @import("harness_skill.zig").HarnessSkill;
const HarnessStatus = @import("harness_status.zig").HarnessStatus;
const HarnessSystemContentBlock = @import("harness_system_content_block.zig").HarnessSystemContentBlock;
const HarnessTool = @import("harness_tool.zig").HarnessTool;
const HarnessTruncationConfiguration = @import("harness_truncation_configuration.zig").HarnessTruncationConfiguration;

/// Representation of a harness.
pub const Harness = struct {
    /// The allowed tools of the harness. All tools are allowed by default.
    allowed_tools: []const []const u8,

    /// The ARN of the harness.
    arn: []const u8,

    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The createdAt time of the harness.
    created_at: i64,

    /// The compute environment on which the Harness runs.
    environment: HarnessEnvironmentProvider,

    /// The environment artifact (e.g., container) in which the Harness operates.
    environment_artifact: ?HarnessEnvironmentArtifact = null,

    /// Environment variables exposed in the environment in which the harness
    /// operates.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// IAM role the harness assumes when running.
    execution_role_arn: []const u8,

    /// Reason why create or update operations fail.
    failure_reason: ?[]const u8 = null,

    /// The ID of the harness.
    harness_id: []const u8,

    /// The name of the harness.
    harness_name: []const u8,

    /// The version of the harness. Incremented on every successful UpdateHarness.
    harness_version: ?[]const u8 = null,

    /// The lifecycle hooks configured for the harness.
    hooks: ?[]const HarnessHook = null,

    /// The maximum number of iterations in the agent loop allowed before exiting
    /// per invocation.
    max_iterations: ?i32 = null,

    /// The maximum total number of output tokens the agent can generate across all
    /// model calls within a single invocation.
    max_tokens: ?i32 = null,

    /// AgentCore Memory instance configuration for short and long term memory.
    memory: ?HarnessMemoryConfiguration = null,

    /// The configuration of the default model used by the Harness.
    model: HarnessModelConfiguration,

    /// The skills of the harness.
    skills: []const HarnessSkill,

    /// The status of the harness.
    status: HarnessStatus,

    /// The system prompt of the harness.
    system_prompt: []const HarnessSystemContentBlock,

    /// The maximum duration per invocation.
    timeout_seconds: ?i32 = null,

    /// The tools of the harness.
    tools: []const HarnessTool,

    /// Configuration for truncating model context.
    truncation: HarnessTruncationConfiguration,

    /// The updatedAt time of the harness.
    updated_at: i64,

    pub const json_field_names = .{
        .allowed_tools = "allowedTools",
        .arn = "arn",
        .authorizer_configuration = "authorizerConfiguration",
        .created_at = "createdAt",
        .environment = "environment",
        .environment_artifact = "environmentArtifact",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .failure_reason = "failureReason",
        .harness_id = "harnessId",
        .harness_name = "harnessName",
        .harness_version = "harnessVersion",
        .hooks = "hooks",
        .max_iterations = "maxIterations",
        .max_tokens = "maxTokens",
        .memory = "memory",
        .model = "model",
        .skills = "skills",
        .status = "status",
        .system_prompt = "systemPrompt",
        .timeout_seconds = "timeoutSeconds",
        .tools = "tools",
        .truncation = "truncation",
        .updated_at = "updatedAt",
    };
};
