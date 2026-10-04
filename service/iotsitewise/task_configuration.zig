const ContainerTaskConfiguration = @import("container_task_configuration.zig").ContainerTaskConfiguration;

/// The task execution configuration. Specify a
/// [containerTaskConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_ContainerTaskConfiguration.html) for a custom container workload.
pub const TaskConfiguration = union(enum) {
    /// Configuration for running a custom container image on managed compute.
    container_task_configuration: ?ContainerTaskConfiguration,

    pub const json_field_names = .{
        .container_task_configuration = "containerTaskConfiguration",
    };
};
