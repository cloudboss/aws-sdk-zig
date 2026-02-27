const MemorySizeConfiguration = @import("memory_size_configuration.zig").MemorySizeConfiguration;

/// Describes the container configurations within the tasks of your Amazon ECS
/// service.
pub const ContainerConfiguration = struct {
    /// The name of the container.
    container_name: ?[]const u8,

    /// The number of CPU units reserved for the container.
    cpu: ?i32,

    /// The memory size configurations for the container.
    memory_size_configuration: ?MemorySizeConfiguration,

    pub const json_field_names = .{
        .container_name = "containerName",
        .cpu = "cpu",
        .memory_size_configuration = "memorySizeConfiguration",
    };
};
