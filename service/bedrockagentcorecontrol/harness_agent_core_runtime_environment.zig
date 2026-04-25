const FilesystemConfiguration = @import("filesystem_configuration.zig").FilesystemConfiguration;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;

/// The AgentCore Runtime environment for a harness.
pub const HarnessAgentCoreRuntimeEnvironment = struct {
    /// The ARN of the underlying AgentCore Runtime.
    agent_runtime_arn: []const u8,

    /// The ID of the underlying AgentCore Runtime.
    agent_runtime_id: []const u8,

    /// The name of the underlying AgentCore Runtime.
    agent_runtime_name: []const u8,

    /// The filesystem configurations for the runtime environment.
    filesystem_configurations: ?[]const FilesystemConfiguration = null,

    lifecycle_configuration: LifecycleConfiguration,

    network_configuration: NetworkConfiguration,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_name = "agentRuntimeName",
        .filesystem_configurations = "filesystemConfigurations",
        .lifecycle_configuration = "lifecycleConfiguration",
        .network_configuration = "networkConfiguration",
    };
};
