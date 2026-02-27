const CodeConfiguration = @import("code_configuration.zig").CodeConfiguration;
const ContainerConfiguration = @import("container_configuration.zig").ContainerConfiguration;

/// The artifact of the agent.
pub const AgentRuntimeArtifact = union(enum) {
    /// The code configuration for the agent runtime artifact, including the source
    /// code location and execution settings.
    code_configuration: ?CodeConfiguration,
    /// The container configuration for the agent artifact.
    container_configuration: ?ContainerConfiguration,

    pub const json_field_names = .{
        .code_configuration = "codeConfiguration",
        .container_configuration = "containerConfiguration",
    };
};
