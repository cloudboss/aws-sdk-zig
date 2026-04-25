/// The Docker and Amazon ECS container agent version information about a
/// container instance.
pub const VersionInfo = struct {
    /// The Git commit hash for the Amazon ECS container agent build on the
    /// [amazon-ecs-agent ](https://github.com/aws/amazon-ecs-agent) GitHub
    /// repository.
    agent_hash: ?[]const u8 = null,

    /// The version number of the Amazon ECS container agent.
    agent_version: ?[]const u8 = null,

    /// The Docker version that's running on the container instance.
    docker_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_hash = "agentHash",
        .agent_version = "agentVersion",
        .docker_version = "dockerVersion",
    };
};
