const CPUArchitecture = @import("cpu_architecture.zig").CPUArchitecture;
const OSFamily = @import("os_family.zig").OSFamily;

/// Information about the platform for the Amazon ECS service or task.
///
/// For more information about `RuntimePlatform`, see
/// [RuntimePlatform](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#runtime-platform) in the *Amazon Elastic Container Service Developer Guide*.
pub const RuntimePlatform = struct {
    /// The CPU architecture.
    ///
    /// You can run your Linux tasks on an ARM-based platform by setting the value
    /// to `ARM64`. This option is available for tasks that run on Linux Amazon EC2
    /// instance, Amazon ECS Managed Instances, or Linux containers on Fargate.
    cpu_architecture: ?CPUArchitecture = null,

    /// The operating system.
    operating_system_family: ?OSFamily = null,

    pub const json_field_names = .{
        .cpu_architecture = "cpuArchitecture",
        .operating_system_family = "operatingSystemFamily",
    };
};
