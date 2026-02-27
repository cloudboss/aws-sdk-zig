const MemorySizeConfiguration = @import("memory_size_configuration.zig").MemorySizeConfiguration;

/// The CPU and memory recommendations for a container within the tasks of your
/// Amazon ECS service.
pub const ContainerRecommendation = struct {
    /// The name of the container.
    container_name: ?[]const u8,

    /// The recommended number of CPU units reserved for the container.
    cpu: ?i32,

    /// The recommended memory size configurations for the container.
    memory_size_configuration: ?MemorySizeConfiguration,

    pub const json_field_names = .{
        .container_name = "containerName",
        .cpu = "cpu",
        .memory_size_configuration = "memorySizeConfiguration",
    };
};
